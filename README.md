インフラポンポンセット
=====================

## 事前条件
DockerとOpenvSwtichが導入済みであること。
*dockerコマンドと、ovs-dockerが通れば特に問題はないはず。*

## 基本的な使い方
各種パラメータを設定した後、**管理者権限で** 欲しいサービスの``install.sh``を実行すると設定した通りにL2疎通が取れるインフラが出来上がる。
TODO: systemdのunitファイルを記述してOpenvSwitchのネットワーク構成に依存して立ち上がるようにする。

## 各種パラメータ
``settings.env``を変更するだけで、基礎的な変更は全て行える。
TODO: makefileとかもっとマシな方法にする

## OpenvSwitchによるネットワーク構成**必須**
``$VSWTICH_NAME``でスイッチを作成。ホストの``$IFACE``を出口として、既存のネットワークインフラとL2で疎通。
デフォルトゲートウェイは``$CT_GATEWAY``で設定し、すべてのホストに適用される。
基本的にすべてのコンテナ内へのアクセス用として、``$**_IF0``にて指定した名前でスイッチ、``$VSWTICH_NAME``へ接続される。

## SoftEtherVPN
Docker:[siomiz/softethervpn](https://hub.docker.com/r/siomiz/softethervpn/)に依存。
リポジトリのルートに``vpn_server.config``を当該のDockerにより作成、保存しておくこと。
``$SE_IF1``は設定によりローカルブリッジとしての利用を想定。

## Samba
Docker:[dperson/samba](https://hub.docker.com/r/dperson/samba/)に依存。
設定ファイルではなく共有ディレクトリをボリュームとして、設定をオプションとして渡す。

## isc-dhcp-server
Docker:[jkoelker/isc-dhcpd](https://hub.docker.com/r/jkoelker/isc-dhcpd/)に依存。
リポジトリのルートに``dhcpd.conf``を作成、保存しておくこと。
