#Creating aws_iam_role resource to atribute permissions for our users
resource "aws_iam_role" "positionRole" {
  name = "${var.iamPosition}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com","ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })
}


#Creating the policy of aws_iam_role(aws_iam_role_policy) for allow the ECS connect with the ECR
resource "aws_iam_role_policy" "ecs_to_Ecr_role" {
  name = "ecs_to_Ecr_role"
  role = aws_iam_role.positionRole.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",                                   /* Here (line 31 until line 36) we have some actions (permissions) to be applied at policy */
          "ecr:BatchCheckLayerAvailability", 
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream", 
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "${var.iamPosition}_profile"
  role = aws_iam_role.positionRole.name
}