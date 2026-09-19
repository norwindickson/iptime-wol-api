# iptime-wol-api

## 동작 방식

```text
iptime-wol-api
  → ipTIME DDNS
  → /cgi/service.cgi
  → session/login
  → wol/show로 MAC 등록 여부 확인
  → wol/signal 호출
  → 공유기가 LAN으로 WOL 패킷 전송
```

대상 MAC 주소가 ipTIME 공유기의 WOL 목록에 등록되어 있는지 확인한 뒤에만 WOL 신호를 보냄

## 요구 사항

- Linux 환경 (Windows 호환여부 체크x)
- `bash`
- `curl`
- `python3`
- ipTIME DDNS 세팅
- ipTIME 원격 관리 기능
- ipTIME WOL 메뉴에 등록된 대상 컴퓨터
- 대상 컴퓨터의 BIOS/UEFI 및 유선 랜카드 WOL 설정

## 설치

```bash
git clone https://github.com/norwindickson/iptime-wol-api.git
cd iptime-wol-api
./install.sh
```

```text
~/.config/iptime-wol-api/iptime.env
```

```bash
$EDITOR ~/.config/iptime-wol-api/iptime.env
chmod 600 ~/.config/iptime-wol-api/iptime.env
```

```dotenv
IPTIME_HOST='your-ddns-host'
IPTIME_PORT='1234'
IPTIME_WOL_USER='router-admin-user'
# Set IPTIME_WOL_PASS only in the local config file.
IPTIME_WOL_MAC='<your-mac-address>'
```

## 실행

```bash
iptime-wol-api
```

성공하면 다음과 같은 결과가 출력

```text
WOL_RESULT=done
```

## 테스트

저장소에는 개인정보와 실제 배포 식별자가 포함되지 않았는지 확인하는 정적 테스트가 포함됨

```bash
./tests/test_static.sh
```

실제 WOL 요청을 테스트하려면 로컬 설정 파일을 준비한 뒤 다음 명령을 실행

```bash
iptime-wol-api
```

## 라이선스

MIT
