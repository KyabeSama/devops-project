resource "aws_iam_role" "eks_cluster_role" {
  count = local.env != "default" ? 1 : 0

  name = "eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "eks_node_group_role" {
  count = local.env != "default" ? 1 : 0

  name = "eks_node_group_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_policy" "eks_node_group_ec2_policy" {
  count = local.env != "default" ? 1 : 0

  name        = "eks_node_group_ec2_policy"
  description = "Policy for EKS node group to interact with EC2"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateVolume",
          "ec2:DeleteVolume",
          "ec2:AttachVolume",
          "ec2:DetachVolume",
          "ec2:DescribeVolumes"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_ec2_policy_attachment" {
  count = local.env != "default" ? 1 : 0

  policy_arn = aws_iam_policy.eks_node_group_ec2_policy[0].arn
  role       = aws_iam_role.eks_node_group_role[0].name
}
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  count = local.env != "default" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  count = local.env != "default" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKSWorkerNodePolicy" {
  count = local.env != "default" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEC2ContainerRegistryReadOnly" {
  count = local.env != "default" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role[0].name
}

resource "aws_iam_role_policy_attachment" "eks_node_group_AmazonEKS_CNI_Policy" {
  count = local.env != "default" ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role[0].name
}

resource "aws_iam_openid_connect_provider" "eks" {
  count = local.env != "default" ? 1 : 0

  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b3b2f8dadf9d9a3a4"]
  url             = aws_eks_cluster.devops-project[0].identity[0].oidc[0].issuer
}

resource "aws_iam_role" "irsa_role" {
  count = local.env != "default" ? 1 : 0

  name = "irsa_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks[0].arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_eks_cluster.devops-project[0].identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:default:my-service-account"
          }
        }
      }
    ]
  })
}
