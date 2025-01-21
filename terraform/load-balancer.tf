# resource "aws_iam_role" "lb_controller" {
#   name = "gros-lb-controller-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Federated = aws_iam_openid_connect_provider.eks.arn
#         }
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Condition = {
#           StringEquals = {
#             "${replace(aws_eks_cluster.devops-project.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "lb_controller_policy" {
#   name        = "gros-lb-controller-policy"
#   description = "IAM policy for AWS Load Balancer Controller"
#   policy      = file("load-balancer-policy.json")
# }

# resource "aws_iam_role_policy_attachment" "lb_controller_attach" {
#   role       = aws_iam_role.lb_controller.name
#   policy_arn = aws_iam_policy.lb_controller_policy.arn
# }
