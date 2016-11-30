インフラポンポンセット
=====================

## 事前条件
DockerとOpenvSwtichが導入済みであること。``docker``,``ovs-docker``コマンドが通ること。
OpenvSwitchでフラットに動作させるための物理または仮想のI/Fがあること。

## 入れ方 
``make.sh``の実行で、配置したディレクトリに対応したUnitファイルを生成。
systemdのディレクトリへ生成したやつを設置。雑にやるなら下記の通り。

```
$ sudo cp *.service /etc/systemd/system
```

## 使い方
あと、``settins.env``の編集も忘れずに。
``systemd {enable|disable|start|stop} infra-portable@{service_name}``の操作が行える。
実際は、``service_name``のディレクトリ直下にある``start_stop.sh {start|stop}``を動かしているだけ。 

## 増やし方
enable時の@以下はディレクトリ名となっているので、
リポジトリにフォルダを追加し、その配下に``start_stop.sh {start|stop}``で、
開始終了できる形態になっていれば実は何でもよかったりする。

## 各種パラメータ
``settings.env``を変更するだけで、基礎的な変更は全て行える。

## OpenvSwitchによるネットワーク構成 *必須*
``$VSWTICH_NAME``でスイッチを作成。ホストの``$IFACE``を出口として、既存のネットワークインフラとL2で疎通。
デフォルトゲートウェイは``$CT_GATEWAY``で設定し、すべてのホストに適用される。
基本的にすべてのコンテナ内へのアクセス用として、``$**_IF0``にて指定した名前でスイッチ、``$VSWTICH_NAME``へ接続される。

## SoftEtherVPN
Docker:[siomiz/softethervpn](https://hub.docker.com/r/siomiz/softethervpn/)に依存。
``/softether``に``vpn_server.config``を作成、保存しておくこと。
``$SE_IF1``は設定によりローカルブリッジとしての利用を想定。

## Samba
Docker:[dperson/samba](https://hub.docker.com/r/dperson/samba/)に依存。
共有するディレクトリをボリュームとして当て、設定をオプションとして渡すこと。

## kea-dhcp4
Docker:[chakphanu/kea](https://hub.docker.com/r/chakphanu/kea/)に依存。
``/kea``に``kea-dhcp4.conf``を作成、配置しておくこと。


