[![Massdriver][logo]][website]

# aws-ecs-cluster

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

AWS ECS is Amazon's fully managed container orchestration service, making it easy for users to deploy, manage and scale containerized workloads.

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![CIS AWS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=CIS+AWS+V1.2) | Center for Internet Security, AWS Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/aws-ecs-cluster/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Faws-ecs-cluster&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`cluster`** *(object)*
  - **`ingress`** *(object)*: Configure network ingress for your ECS cluster.
    - **`enable_ingress`** *(boolean)*: Enabling ingress will create an ALB for your cluster to securely route traffic to your workloads. Default: `False`.
  - **`instances`** *(array)*: AWS EC2 instances to associate with your ECS cluster for running workloads.
    - **Items** *(object)*
      - **`instance_type`** *(string)*: Instance type to use in the node group.
        - **One of**
          - C5 High-CPU Large (2 vCPUs, 4.0 GiB)
          - C5 High-CPU Extra Large (4 vCPUs, 8.0 GiB)
          - C5 High-CPU Double Extra Large (8 vCPUs, 16.0 GiB)
          - C5 High-CPU Quadruple Extra Large (16 vCPUs, 32.0 GiB)
          - C5 High-CPU 9xlarge (36 vCPUs, 72.0 GiB)
          - C5 High-CPU 12xlarge (48 vCPUs, 96.0 GiB)
          - C5 High-CPU 18xlarge (72 vCPUs, 144.0 GiB)
          - C5 High-CPU 24xlarge (96 vCPUs, 192.0 GiB)
          - M5 General Purpose Large (2 vCPUs, 8.0 GiB)
          - M5 General Purpose Extra Large (4 vCPUs, 16.0 GiB)
          - M5 General Purpose Double Extra Large (8 vCPUs, 32.0 GiB)
          - M5 General Purpose Quadruple Extra Large (16 vCPUs, 64.0 GiB)
          - M5 General Purpose Eight Extra Large (32 vCPUs, 128.0 GiB)
          - M5 General Purpose 12xlarge (48 vCPUs, 192.0 GiB)
          - M5 General Purpose 16xlarge (64 vCPUs, 256.0 GiB)
          - M5 General Purpose 24xlarge (96 vCPUs, 384.0 GiB)
          - T3 Small (2 vCPUs for a 4h 48m burst, 2.0 GiB)
          - T3 Medium (2 vCPUs for a 4h 48m burst, 4.0 GiB)
          - T3 Large (2 vCPUs for a 7h 12m burst, 8.0 GiB)
          - T3 Extra Large (4 vCPUs for a 9h 36m burst, 16.0 GiB)
          - T3 Double Extra Large (8 vCPUs for a 9h 36m burst, 32.0 GiB)
          - P2 General Purpose GPU Extra Large (4 vCPUs, 61.0 GiB)
          - P2 General Purpose GPU Eight Extra Large (32 vCPUs, 488.0 GiB)
          - P2 General Purpose GPU 16xlarge (64 vCPUs, 732.0 GiB)
          - G5 Single GPU Extra Large (4 vCPUs, 16 GiB)
          - G5 Single GPU Two Extra Large (8 vCPUs, 32 GiB)
          - G5 Single GPU Four Extra Large (16 vCPUs, 64 GiB)
      - **`max_size`** *(integer)*: Maximum number of instances in the node group. Minimum: `0`. Default: `10`.
      - **`min_size`** *(integer)*: Minimum number of instances in the node group. Minimum: `0`. Default: `1`.
      - **`name`** *(string)*: The name of the node group. Default: ``.
## Examples

  ```json
  {
      "__name": "Development",
      "cluster": {
          "instances": [
              {
                  "instance_type": "t3.medium",
                  "max_size": 10,
                  "min_size": 1,
                  "name": "instances"
              }
          ]
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "cluster": {
          "instances": [
              {
                  "instance_type": "t3.medium",
                  "max_size": 10,
                  "min_size": 1,
                  "name": "instances"
              }
          ]
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`vpc`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`cluster`** *(object)*: Cannot contain additional properties.
  - **`data`** *(object)*
    - **`capabilities`** *(object)*
      - **`ingress`** *(array)*: Default: `[]`.
        - **Items** *(object)*
          - **`listeners`** *(array)*
            - **Items** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`domains`** *(array)*: Default: `[]`.
                - **Items** *(string)*
              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['http', 'https']`.
          - **`load_balancer_arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`security_group_arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`vpc`** *(object)*: . Cannot contain additional properties.
        - **`data`** *(object)*
          - **`infrastructure`** *(object)*
            - **`arn`** *(string)*: Amazon Resource Name.

              Examples:
              ```json
              "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
              ```

              ```json
              "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
              ```

            - **`cidr`** *(string)*

              Examples:
              ```json
              "10.100.0.0/16"
              ```

              ```json
              "192.24.12.0/22"
              ```

            - **`internal_subnets`** *(array)*
              - **Items** *(object)*: AWS VCP Subnet.
                - **`arn`** *(string)*: Amazon Resource Name.

                  Examples:
                  ```json
                  "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                  ```

                  ```json
                  "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                  ```

                - **`aws_zone`** *(string)*: AWS Availability Zone.

                  Examples:
                - **`cidr`** *(string)*

                  Examples:
                  ```json
                  "10.100.0.0/16"
                  ```

                  ```json
                  "192.24.12.0/22"
                  ```


                Examples:
            - **`private_subnets`** *(array)*
              - **Items** *(object)*: AWS VCP Subnet.
                - **`arn`** *(string)*: Amazon Resource Name.

                  Examples:
                  ```json
                  "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                  ```

                  ```json
                  "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                  ```

                - **`aws_zone`** *(string)*: AWS Availability Zone.

                  Examples:
                - **`cidr`** *(string)*

                  Examples:
                  ```json
                  "10.100.0.0/16"
                  ```

                  ```json
                  "192.24.12.0/22"
                  ```


                Examples:
            - **`public_subnets`** *(array)*
              - **Items** *(object)*: AWS VCP Subnet.
                - **`arn`** *(string)*: Amazon Resource Name.

                  Examples:
                  ```json
                  "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                  ```

                  ```json
                  "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                  ```

                - **`aws_zone`** *(string)*: AWS Availability Zone.

                  Examples:
                - **`cidr`** *(string)*

                  Examples:
                  ```json
                  "10.100.0.0/16"
                  ```

                  ```json
                  "192.24.12.0/22"
                  ```


                Examples:
        - **`specs`** *(object)*
          - **`aws`** *(object)*: .
            - **`region`** *(string)*: AWS Region to provision in.

              Examples:
              ```json
              "us-west-2"
              ```

    - **`security`** *(object)*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
      - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
        - **`^[a-z]+[a-z_]*[a-z]+$`** *(object)*
          - **`policy_arn`** *(string)*: AWS IAM policy ARN.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

      - **`identity`** *(object)*: For instances where IAM policies must be attached to a role attached to an AWS resource, for instance AWS Eventbridge to Firehose, this attribute should be used to allow the downstream to attach it's policies (Firehose) directly to the IAM role created by the upstream (Eventbridge). It is important to remember that connections in massdriver are one way, this scheme perserves the dependency relationship while allowing bundles to control the lifecycles of resources under it's management. Cannot contain additional properties.
        - **`role_arn`** *(string)*: ARN for this resources IAM Role.

          Examples:
          ```json
          "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
          ```

          ```json
          "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
          ```

      - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
        - **`^[a-z-]+$`** *(object)*
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
          - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/aws-ecs-cluster/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=linkedin

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/issues
[release_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/aws-ecs-cluster.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/aws-ecs-cluster/blob/main/LICENSE

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2

[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=aws-ecs-cluster&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
