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

## Docker Compose build create and starte Jupyter server

```bash
# go to docker folder of your local,
# my local is ~/touchgrass/introdatascience/docker
cd ~/touchgrass/introdatascience/docker; ls -la

# check the current status.
cd ~/touchgrass/introdatascience/docker; docker compose ps
cd ~/touchgrass/introdatascience/docker; docker compose ls

# create image.
cd ~/touchgrass/introdatascience/docker; docker compose create
cd ~/touchgrass/introdatascience/docker; docker compose build

# start notebook server
cd ~/touchgrass/introdatascience/docker; docker compose start
cd ~/touchgrass/introdatascience/docker; docker compose restart
```

check docker logs to get token

```bash
cd ~/touchgrass/introdatascience/docker; docker compose logs --help
cd ~/touchgrass/introdatascience/docker; docker compose logs mynotebook
# option -f will tail the logging message.
# docker tail log
cd ~/touchgrass/introdatascience/docker; docker compose logs -f mynotebook
```

### explore the jupypter container folder tructure

We need find the work folder to map to local.
User: jovyan
Home folder: /home/jovyan
Work folder: /home/jovyan/work

```bash
docker exec mynotebook pwd
docker exec mynotebook ls -la
docker exec mynotebook ls -la work
```

### tear down everything

```bash
# NOTE: this command will remove everything.
cd ~/touchgrass/introdatascience/docker; docker compose down
```
