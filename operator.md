## AWS ECS Cluster

Amazon Elastic Container Service (ECS) is a fully managed container orchestration service that makes it easy to deploy, manage, and scale containerized applications using Docker. It allows you to focus on building and running applications instead of managing the underlying infrastructure.

### Design Decisions

1. **Ingress Configuration**: The module allows enabling or disabling ingress capabilities.
2. **Security Group Management**: Automatic creation of security groups for the Application Load Balancer (ALB) and ECS instances.
3. **ALB Configuration**: Conditional setup of ALB depending on the ingress setting, including HTTPS redirection.
4. **Certificate Management**: Support for the creation and attachment of ACM certificates for the default and additional Route 53 zones.
5. **Auto Scaling**: ECS capacity providers are managed in conjunction with auto-scaling groups for instance management.
6. **IAM Roles and Policies**: Instance profile roles are created and attached with necessary policies.
7. **Cluster Insights**: Container insights are enabled to provide better analytics and monitoring for the cluster.
8. **Workarounds**: Implemented with a time sleep resource to coordinate ASG and capacity providers due to existing Terraform provider issues.

### Runbook

#### ECS Cluster Instances Not Starting

If your ECS cluster instances are not starting, ensure that the necessary permissions and configurations are in place.

1. **Check ECS Agent Logs on EC2 Instances**

   SSH into one of your ECS instances and check the ECS agent logs. 

   ```sh
   sudo cat /var/log/ecs/ecs-agent.log
   ```

   You should look for any error messages or issues related to the cluster registration.

2. **Check Auto Scaling Group (ASG) Health**

   Verify the health of your auto-scaling group instances:

   ```sh
   aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names <Your-ASG-Name>
   ```

3. **Verify Instance Profile and Permissions**

   Ensure that the instance profile attached to ECS instances has the correct permissions. List the attached IAM policies:

   ```sh
   aws iam list-role-policies --role-name <Your-Instance-Profile-Role>
   ```

#### ALB Not Serving Traffic

If your ALB is not serving traffic correctly, follow these steps:

1. **Check ALB Listener Configuration**

   Ensure that the ALB listeners are configured correctly:

   ```sh
   aws elbv2 describe-listeners --load-balancer-arn <Your-ALB-ARN>
   ```

   Confirm the listener protocols, ports, and rules.

2. **Verify ALB Security Groups**

   Ensure the ALB security group has the correct inbound rules to allow HTTP and HTTPS traffic:

   ```sh
   aws ec2 describe-security-groups --group-ids <Your-ALB-Security-Group-ID>
   ```

3. **Check Route 53 DNS Records**

   Ensure the DNS records for your domain are correctly pointing to the ALB:

   ```sh
   aws route53 list-resource-record-sets --hosted-zone-id <Your-Hosted-Zone-ID>
   ```

#### ECS Task Not Starting

1. **Check ECS Task Status**

   List the tasks in the cluster to see their current status:

   ```sh
   aws ecs list-tasks --cluster <Your-Cluster-Name>
   ```

2. **Describe ECS Task**

   Describe the task to get detailed information about failure reasons:

   ```sh
   aws ecs describe-tasks --cluster <Your-Cluster-Name> --tasks <Task-ID>
   ```

3. **Check Service Logs**

   If the task is part of a service, check the service logs to identify issues:

   ```sh
   aws logs describe-log-streams --log-group-name <Your-Log-Group-Name>
   aws logs get-log-events --log-group-name <Your-Log-Group-Name> --log-stream-name <Your-Log-Stream-Name>
   ```

Ensure you follow these troubleshooting steps to maintain the health and functionality of your ECS cluster.


