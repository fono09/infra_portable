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

## 各種パラメータと構成
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

### OpenvSwitchによるネットワーク構成 *必須*
``Networks``セクションに記述されている。

### SoftEtherVPN
Docker:[siomiz/softethervpn](https://hub.docker.com/r/siomiz/softethervpn/)に依存。
``/softether``に``vpn_server.config``を作成、保存しておくこと。

### Samba
Docker:[dperson/samba](https://hub.docker.com/r/dperson/samba/)に依存。
* ``SMB_VOLUMES``
Dockerの``-v /foo:/bar -v /buzz:/foobar...``の形で書く。
* ``SMB_OPTIONS``
DockerHubのページのOptionsを参照

### kea-dhcp
Docker:[chakphanu/kea](https://hub.docker.com/r/chakphanu/kea/)に依存。
``/kea``に``kea-dhcp4.conf``を作成、配置しておくこと。
特記事項なし

