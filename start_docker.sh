if [ -d ./storage ]; then
  echo "storage directory exists"
else
  mkdir storage
  chmod 777 -R storage
fi

docker stop ivycms
docker run --rm -p 12308:3000 --cpus=2 -m 512m -v ./storage:/rails/storage -e SECRET_KEY_BASE=b086c088edbd5e8626401d4f5df99b1a633b6ec343c3bc5810a1fc287eded211d6cb85e91739cddac92eb84b52029f3f2e7461ac1d1a58f6a4fd76bc070c6083 -e TZ=Asia/Singapore --name ivycms ivycms:latest
