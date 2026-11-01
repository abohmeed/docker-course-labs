# تصحيح سريع: Anonymous volumes

في المحاضرة اتقال إن الـ anonymous volume بيتشال مع الكونتينر. التدقيق الأدق حسب وثائق Docker:

- الـ anonymous volume **مش** بيتشال تلقائياً لما الكونتينر يتمسح بأمر عادي زي `docker rm`.
- بيتشال مع الكونتينر لما تشغّل بـ `--rm` (أو سياسة تنظيف مشابهة)، أو لما تمسحه صراحة بـ `docker volume rm` / `docker volume prune`.

يعني: الارتباط مش "أي kill للكونتينر"، لكن مع إزالة الكونتينر في سياق `--rm` أو تنظيف الـ volumes اليتيمة.

لو حابب تتأكد بعد تجربة:
```
docker volume ls
docker volume prune
```

حدّثت نوفمبر 2026 — DevCloudLab
