インフラポンポンセット
=====================

## 事前条件
DockerとOpenvSwtichが導入済みであること。``docker``,``ovs-docker``コマンドが通ること。
OpenvSwitchでフラットに動作させるための物理または仮想のI/Fがあること。

## 入れ方 
``make.sh``の実行で、配置したディレクトリに対応したUnitファイルを生成。
systemdのディレクトリへ生成したやつを設置。あと、systemd側でdaemon-reload/enableする。
このテンプレートで展開する全てのサービスは``infra-portable-openvswitch``に依存している。

```
$ ./make.sh
# cp *.service /etc/systemd/system
# systemctl daemon-reload
# systemctl enable infra-portable-openvswtich
```

## 使い方
あと、``settins.env``の編集も忘れずに。サンプルは``settings.env.pre``
``systemd {enable|disable|start|stop} infra-portable@{service_name}``の操作が行える。
実際は、``service_name``のディレクトリ直下にある``start_stop.sh {start|stop}``を動かしているだけ。 

## 増やし方
``/skel``を参照。
enable時の@以下はディレクトリ名となっているので、
リポジトリにフォルダを追加し、その配下に``start_stop.sh {start|stop}``で、
開始終了できる形態になっていれば実は何でもよかったりする。

## 各種パラメータ
``settings.env``を変更するだけで、基礎的な変更は全て行える。

### Networksセクション
* ``IFACE``
出口となる物理インターフェイス名
* ``VSWITCH_NAME``
仮想スイッチの名前(任意)
* ``CT_GATEWAY``
L2対外疎通をとるので、デフォルトゲートウェイの設定
(0番目のインターフェイスに当たる)

### 一般
* ``(\w+)_CT_ADDR``
サービス``$1``のコンテナに当てるIPアドレス(IPv4 address)
(0番目のインターフェイスに当たる)
* ``(\w+)_CT_NAME``
サービス``$1``のコンテナ名(String)
* ``(\w+)_IF(\d)``
サービス``$1``のコンテナに当てる、``$2``番目のインターフェイス名(String)

### SoftEtherVPN
特記事項なし

### Samba
* ``SMB_VOLUMES``
Dockerの``-v /foo:/bar -v /buzz:/foobar...``の形で書く。
* ``SMB_OPTIONS``
[DockerHub:dperson/samba](https://hub.docker.com/r/dperson/samba/)のOptionsを参照

### kea-dhcp
特記事項なし

