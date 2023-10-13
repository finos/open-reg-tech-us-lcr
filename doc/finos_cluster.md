# FINOS LCR Server

FINOS runs a server with the [latest interactive documentation](https://lcr-interactive.finos.org/).

<br/><br/>

### For Conributors: Managing Update ECS cluster
- Access ECS Cluster on https://us-east-1.console.aws.amazon.com/ecs/home?region=us-east-1#/clusters and select the LCR cluster
- Access the `Task Definitions` menu item and select the `lcr-interactive` task
- Select the latest revision
- Click on `Create new revision`
- Scroll down and click on `Add container`
    - container name: `lcr-morphir`
    - image: `finos/lcr-interactive:main` (use main by default unless asked otherwise. If needed replace `main` with the name of the code branch that should be deployed)
    - port mappings: `3000, tcp`
    - Keep other values as they are and complete the form to add the container
    - Remove the other container from the list
    - Keep other values as they are and complete the form by clicking "create" to add a new task definition revision
- Select the LCR service and click on the Update button
    - Update the task definition revision
    - Keep other values as they are and complete the form to update the service
- Access the `Tasks` tab of the cluster service
- Keep only one Task running, remove all tasks with older task definitions
