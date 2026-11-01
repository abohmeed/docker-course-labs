# Lecture 15: Running Docker images on AWS Elastic Beanstalk (AL2023)

> **بالعربي باختصار:** هنرفع موقع static جوه nginx container على Elastic Beanstalk، platform اسمها **Docker running on 64bit Amazon Linux 2023**. اختار **Standard** مش Cluster، و **Single instance** عشان التكلفة. وفي الآخر اعمل **Terminate** للـ environment.

Updated 2026-11. The old lecture used the Amazon Linux 2 Docker platform, which AWS retired on 2026-08-06.

## What's here

| Path | Use |
|---|---|
| `app/Dockerfile` + `app/site/` | Beanstalk builds the image on the instance (zip upload or EB CLI) |
| `image-only/Dockerrun.aws.json` | Same thing without a Dockerfile: Beanstalk pulls a public image (v1 file, no Compose) |
| `build-zip.sh` | Makes `app.zip` with `Dockerfile` at the ZIP root |

## Option A: console

1. `./build-zip.sh` (Windows: open the `app` folder, select `Dockerfile` + `site`, Send to > Compressed folder). The `Dockerfile` must be at the ZIP root, not inside a folder.
2. Elastic Beanstalk console > **Create environment**.
3. Deployment type **Standard** (not Cluster). Tier **Web server**.
4. Platform **Docker**, branch **Docker running on 64bit Amazon Linux 2023**, recommended version.
5. Application code: **Upload your code** > `app.zip`. Preset: **Single instance (free tier eligible)**.
6. Service access: service role + EC2 instance profile. No profile yet? Create role > AWS service > Elastic Beanstalk - Compute.
7. Keep the rest default > Create. Wait about 5 minutes for Health = Ok, open the domain.

## Option B: EB CLI

```bash
cd app
eb init -p docker lecture15-docker --region eu-central-1
eb create lecture15-env --single
eb open
# change site/index.html, then:
eb deploy
eb terminate lecture15-env
```

## Clean up

Terminate the environment when you are done (console: Actions > Terminate environment, or `eb terminate`). Otherwise the EC2 instance keeps billing.

## Troubleshooting

- 502 Bad Gateway: the container is not listening on the `EXPOSE` port. Check `eb logs` or Logs > Request logs.
- "Dockerfile not found": the ZIP has a parent folder. Rebuild it from inside `app/`.
- Instance profile error on create: step 6.
