resource "aws_eks_cluster" "devops-project" {
  count    = local.env != "default" ? 1 : 0
  name     = "gros-devops-project-cluster"
  role_arn = aws_iam_role.eks_cluster_role[0].arn

  vpc_config {
    subnet_ids = concat(aws_subnet.public.*.id, aws_subnet.private.*.id)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSVPCResourceController
  ]
}



resource "aws_eks_node_group" "devops-project-node-group" {
  count = local.env != "default" ? 1 : 0

  cluster_name    = aws_eks_cluster.devops-project[0].name
  node_group_name = "gros-devops-project-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role[0].arn
  subnet_ids      = aws_subnet.private.*.id

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_node_group_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_node_group_AmazonEKS_CNI_Policy
  ]
}


resource "aws_security_group" "eks_cluster_sg" {
  count = local.env != "default" ? 1 : 0

  name        = "eks_cluster_sg"
  description = "EKS Cluster security group"
  vpc_id      = aws_vpc.main[0].id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

