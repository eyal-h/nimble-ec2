# api-ecs-demo-app

## Task 1 - CI/CD

I have used git actions for the CI/CD Pipeline, I Have a lot of knowledge related to Git Actions. 

## STEPS

First Step: 
* Build the docker image. 
* If the build was successful I am publishing it to Docker Hub.

Second Step (Terraform):
* This step must run after build step, I added a dependency to the build step (needs: build).
* I have added terraform format check step and also validation step to help us bad formatting and wrong 
  configuration settings.
* We will apply changes to terraform only if all steps finished successfully.

## Terraform apply / destroy only

I have added the ability to run terraform command as requested in the assignment.
my git action is checking inside the commit message.
**if commit message contains /apply**
* ci process will skip all other steps.
* ci will only trigger terraform apply for the current repository files.

**if commit message contains /destroy**
* ci process will skip all other steps.
* ci will only trigger terraform destroy.

Another way to trigger terraform apply / destroy is from the actions tab:
[actions](https://github.com/eyal-h/nimble/actions)
On the workflows side menu click on Nimble-Apply or Nimble-Destroy
then click on Run workflow and then click on the green Run workflow button.
![Actions Tab Example](https://github.com/eyal-h/nimble/blob/main/Actions.png)


## Note:
* I have no experience with AWS / TERRAFORM. 
   all the things I have implemented was from learning on the go.

* As an Improvement my suggestion is to Implement branch protection.
   all new code will be pushed to a feature branch after it passed tests / lint... the developer will be able to merge it to master branch.

* I had some issue with go mod I have added "RUN go mod init example.com/m" to the Dockerfile to solve it.

## Bonus Task

The main issue that I have found is that when we want to modify the image of an existing resource, the next time we will apply the changes terraform will inform us that existing resource will be destroyed before the new one is created.

To solve this issue we can use the lifecycle configuration which control the lifecycle on the resource.
we will us create_before_destroy flag

The second issue that I have found is that when a server is created by terraform, terraform is unaware if our application is running. clients may be redirected to a new server that was just created, but our application is not running yet. to solve this issue we will add a provisioner which will preform an application health check. terraform will declare that resource was successfully created only when the provisioner has completed without an error. for example we can add an service endpoint (ex: /health) that only when our application is fully started it will return HTTP 200 OK.

we will create a server image and this image will be pushed to the environment with a new version of our app.

I will use blue / green deployment strategy we can use tags. i will deploy new servers and at the end we will redirect the traffic from the load balancer to the new servers.
