## AWS ECS Cluster

Amazon Elastic Container Service (Amazon ECS) is a highly scalable and high-performance container management service. ECS allows you to run and manage Docker containers on a cluster of Amazon EC2 instances. It simplifies running application containers in a highly available, fault-tolerant manner.

### Design Decisions

1. **Ingress Capabilities**:
    - The module includes conditional ingress capabilities managed by AWS Application Load Balancer (ALB). The module dynamically configures ALB, listeners, and security groups based on the `enable_ingress` variable.
   
2. **Certificates**:
    - The module provisions ACM certificates for secure communications. It manages default and additional domain certificates for Route 53 hosted zones.

3. **Capacity Providers**:
    - Utilizes EC2 and Fargate capacity providers. The setup is designed to manage termination protection and scaling configurations.

4. **Security Groups**:
    - Proper security groups are defined and configured for ALB and ECS instances, ensuring necessary ingress and egress permissions.

5. **Auto Scaling**:
    - The EC2 Auto Scaling configuration ensures that ECS instances can scale in and out based on capacity demands, with managed termination protection enabled.

6. **IAM Roles**:
    - The module sets up necessary IAM roles and attaches required IAM policies to manage ECS tasks and instances efficiently.

### Runbook

#### Checking ECS Cluster Health

Verify the overall health and state of your ECS cluster.

```sh
aws ecs describe-clusters --clusters <cluster-name>
```
Expect to see the status and registered container instances.

#### Diagnosing ECS Task Failures

Fetch recent events related to ECS tasks to troubleshoot task failures.

```sh
aws ecs describe-services --cluster <cluster-name> --services <service-name>
```
Look for recent events and status updates that might indicate issues.

#### Troubleshooting Auto Scaling Group (ASG) Issues

Check the status and health of instances in the ASG.

```sh
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names <asg-name>
```
You'll get details on instance statuses, health checks, and scaling activities.

#### Validating ACM Certificates

Ensure that ACM certificates are correctly provisioned and validated.

```sh
aws acm describe-certificate --certificate-arn <certificate-arn>
```
Check the `Status` and `DomainValidationOptions` fields for errors.

#### Verifying ALB Configuration

List listeners associated with the Application Load Balancer.

```sh
aws elbv2 describe-listeners --load-balancer-arn <alb-arn>
```
Ensure listeners are configured correctly for HTTP and HTTPS traffic.

#### Debugging Network Issues on ECS Instances

SSH into ECS instance to diagnose network settings.

```sh
ssh -i <your-key>.pem ec2-user@<instance-public-dns>
```
Check network interface configurations and security group settings.

#### Common Docker Issues on ECS Instances

Manage and troubleshoot Docker containers on ECS instances.

```sh
# List running containers
docker ps

# Check logs for a specific container
docker logs <container-id>

# Inspect container state
docker inspect <container-id>
```
Expect to gain insights into container statuses and logs for further issue resolution.

