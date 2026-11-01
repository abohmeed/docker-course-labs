# Docker Desktop على ويندوز وماك — ملاحظات سريعة

المحاضرات مبنية على Docker Engine على Linux. على ويندوز وماك، Docker Desktop بيشغّل الـ engine جوه Linux VM، فبعض الأوامر والـ paths بتختلف.

## 1) فين تشغّل الأوامر؟
- **Windows:** PowerShell أو CMD أو WSL terminal — المهم إن `docker version` يشتغل من نفس النافذة.
- **macOS:** Terminal.app أو iTerm.
- لو الأمر مش موجود: تأكد إن Docker Desktop شغال (الحوت أخضر) وإن PATH اتظبط بعد التثبيت.

## 2) Host network
- على Linux: `--network host` بيربط الكونتينر مباشرة بشبكة الجهاز.
- على Docker Desktop: تاريخياً host mode كان بيربط بشبكة الـ VM مش جهازك، فـ `localhost` على جهازك مش بيوصل.
- **الحل العملي:** استخدم نشر البورتات، مثال: `docker run -p 8080:80 nginx` وبعدين افتح `http://localhost:8080`.
- من **Docker Desktop 4.34+**: Settings → Resources → Network → Enable host networking (بعد تسجيل الدخول لـ Docker). ده اختياري ومش مطلوب عشان تتبع الكورس.

## 3) فين الـ volumes على ويندوز/ماك؟
- البيانات جوه الـ VM بتاعة Docker Desktop، مش مباشرة تحت مسار Linux زي `/var/lib/docker`.
- استخدم `docker volume inspect VOLUME_NAME` عشان تشوف الـ Mountpoint من وجهة نظر الـ engine.
- للملفات على جهازك: استخدم **bind mount** لمسار ويندوز/ماك (مع مشاركة المجلدات في Docker Desktop Settings → Resources → File sharing لو لزم).

## 4) ليه الكونتينر بيفضل شغال؟
الكونتينر بيقف لما العملية الرئيسية (PID 1) تخلص. صورة زي `ubuntu` من غير أمر بتقف فوراً. صورة زي `nginx` أو تشغيل بـ `-it` بتفضل شغالة. راجع بـ:
```
docker ps
docker ps -a
docker inspect CONTAINER --format '{{.Config.Cmd}}'
```

## 5) DNS بين الكونتينرات (ping: bad address)
الاسم → IP شغال على **user-defined bridge** مش على الـ bridge الافتراضي:
```
docker network create mynet
docker run -d --name a --network mynet nginx
docker run -it --rm --network mynet nicolaka/netshoot ping a
```

حدّثت نوفمبر 2026 — DevCloudLab
