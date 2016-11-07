インフラポンポンセット
=====================

## 以下のセットとなっております
- OpenvSwitchによるネットワーク構成
- SoftEhterVPN
- isc-dhcp-server
- BIND9

## 事前条件
DockerとOpenvSwtichが導入済みであること。
*dockerコマンドと、ovs-dockerが通れば特に問題はないはず。*

## 基本的な使い方
各種パラメータを設定した後、**管理者権限で** ``install.sh``を実行すると設定した通りに綺麗にL2疎通が取れるインフラが出来上がります。

## 各種パラメータ
``settings.env``を変更するだけで、基礎的な変更は全て行えます。

## OpenvSwitchによるネットワーク構成
ブリッジ名``$VSWTICH_NAME``でプロミスキャスモードの``$IFACE``を出口として、既存のネットワークインフラとL2で接続します。
ゲートウェイは``$CT_GATEWAY``で設定し、自動的に外部と疎通が取れるようになります。

## SoftEtherVPN
基本的にDocker:[siomiz/softethervpn](https://hub.docker.com/r/siomiz/softethervpn/)に依存。
リポジトリのルートに``vpn_server.config``を当該のDockerにより作成、保存しておくこと。
コンテナ内に``veth0``,``veth1``を作成し、``veth0``はアクセス用I/F、``veth1``は設定によりローカルブリッジとしての利用を想定。
パラメータも当該のDockerよるものなので、詳細なパラメータはそちらを参照。

