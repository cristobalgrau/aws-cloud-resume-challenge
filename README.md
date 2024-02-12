# The Cloud Resume Challenge

The [Cloud Resume Challenge](https://cloudresumechallenge.dev/) is a challenge created by [Forrest Brazeal](https://forrestbrazeal.com/), where you have to develop 16 steps to create a Static Web page hosted in the cloud to showcase your Resume. With this Challenge, you can show your skills as a Cloud Architect / DevOps demonstrating hands-on on the Cloud, Serverless, Infrastructure as Code (IaC), Source Control, and CI/CD.

## My Architecture diagram

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/751ef6dc-2cdc-43ec-963f-c7589be32d47)

## Step 1. Certification

Before even knowing about the Cloud Resume Challenge I undertook the essential first step of obtaining two AWS Certifications:

- [AWS Certified Cloud Practitioner](https://www.credly.com/badges/aa4eb28a-5b1f-4d94-b2b3-891eabeabf48/public_url) (March 13th, 2022)
- [AWS Certified Solutions Architect - Associate](https://www.credly.com/badges/9bc1aeec-6e7b-4be7-a952-548ea685135d/public_url) (August 12th, 2023)

These certifications would lay a strong foundation for the challenges that awaited in the Cloud Resume Challenge.

## Steps 2 & 3. HTML and CSS

To overcome my initial lack of proficiency in HTML and CSS, I opted to leverage a free template and tailor it to suit my resume. After exploring various options, I settled on a template from [TemplateFlip](https://templateflip.com/), that not only appealed to me aesthetically but also came equipped with a CSS stylesheet.

Acknowledging my limited knowledge of HTML and CSS, I delved into the basics of these languages. Armed with newfound insights, I began customizing the template. This involved a meticulous process of modifying the source code—altering colors, integrating images, adjusting backgrounds, and embedding my AWS certification badges. Additionally, I incorporated links to my LinkedIn and GitHub accounts.

Steps 4, 5 & 6. Static Website, HTTPS, and DNS
To continue with this step you have to have your domain name. I decided to buy one from Namecheap to add a little bit more challenge to the project because you have to set the AWS DNS on your domain name registrar to make it work.

Initiating this phase involved the creation of an S3 bucket to host the HTML code for my resume. The site should use HTTPS for security. To achieve this it is needed to create a CloudFront Distribution, an Origin Access Identity (OAI) to point toward the S3 bucket, configuration of a custom SSL Certificate, and formulation of a bucket policy enabling the CloudFront Distribution to access the HTML code within the bucket.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/dba430a3-5c7a-49f2-8adf-1bf4b99261bb)

With the entire system converging on the S3 bucket, the focus shifted to Route 53 for efficient traffic management under the domain name, rather than relying on the CloudFront Distribution address. This entailed the creation of a hosted zone, coupled with the generation of corresponding records for the domain. With this last step, we obtained the necessary DNS information to configure the domain name registrar from which I purchased my domain name.

![image](https://github.com/cristobalgrau/aws-cloud-resume-challenge/assets/119089907/e0552ac9-bf54-4aaf-ac56-25cfea73598a)
