# Use Docker Compose for Local Jupyter Notebook Development

Docker compose will provide an easy and clean development environment for
Jupyter Notebook.

## install Docker Desktop

Follow Docker website to install Docker Desktop.

Check docker desktop after installation
```bash
docker compose --help
```

## search and replace
```vim
%s/rd\/myworkshopca\/DataScienceBasic/touchgrass\/introdatascience/gc
```

## Docker Compose build create and start Jupyter server

Before you do this, make sure docker is running (open the app)

```bash
# go to docker folder of your local,
# my local is ~/touchgrass/introdatascience/docker
cd ~/touchgrass/introdatascience/docker; ls -la

# check the current status.
cd ~/touchgrass/introdatascience/docker; docker compose ps
cd ~/touchgrass/introdatascience/docker; docker compose ls
# (shell returned 1) --> you sure the app is open?
# compose ps should return something like this, compose ls something similar:
# NAME                IMAGE               COMMAND             SERVICE             CREATED             STATUS              PORTS
# with nothing below every column

# create image.
cd ~/touchgrass/introdatascience/docker; docker compose create
cd ~/touchgrass/introdatascience/docker; docker compose build

# start notebook server
cd ~/touchgrass/introdatascience/docker; docker compose start
cd ~/touchgrass/introdatascience/docker; docker compose restart

# checking status again should show data under to columns
# so should checking the app
```

go to _http://localhost:8888/_, which is where the notebook will run
it will require a token to access, check docker logs to get token
<br>OR<br>
follow the steps below and there will be URLs you can paste directly into the browser

```bash
cd ~/touchgrass/introdatascience/docker; docker compose logs --help
cd ~/touchgrass/introdatascience/docker; docker compose logs mynotebook
# option -f will tail the logging message.
# docker tail log
cd ~/touchgrass/introdatascience/docker; docker compose logs -f mynotebook
```

To save in notebook, use command s or press the save button. <br>
After saving you can simply commit.

### explore the jupypter container folder structure

We need find the work folder to map to local.
User: jovyan
Home folder: /home/jovyan
Work folder: /home/jovyan/work

```bash
docker exec mynotebook pwd
docker exec mynotebook ls -la
docker exec mynotebook ls -la work
```

I need to do something similar for the data set that I moved outside of git because it was too large?

```bash
docker exec mynotebook pwd
docker exec mynotebook ls -la
docker exec mynotebook mkdir largedata
```

and then I'll just manually move the data file there? because I'm not exactly sure how to do it from here.

### tear down everything

```bash
# NOTE: this command will remove everything.
cd ~/touchgrass/introdatascience/docker; docker compose down
```
