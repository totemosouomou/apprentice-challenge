echo "パスワードマネージャーへようこそ！"
next=0

while true;
do
  if [ $next -eq 0 ]; then
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  fi
  next=0
  read input
  case $input in
    Add\ Password)
      echo "サービス名を入力してください："
      read title
      echo "ユーザー名を入力してください："
      read name
      echo "パスワードを入力してください："
      read pass
      echo "パスワードの追加は成功しました。"
      echo $title:$name:$pass >> ./passwords.md
      gpg --yes --output ./passwords.md.gpg --encrypt --recipient totemosouomou@gmail.com ./passwords.md
      chmod go-rwx ./passwords.md
      ;;
    Get\ Password)
      echo "サービス名を入力してください："
      read title
      gpg --yes --output ./passwords.md --decrypt ./passwords.md.gpg 2> /dev/null
      if egrep -q "^$title:" ./passwords.md; then
        IFS=':' read service username password <<< $(egrep "^$title:" ./passwords.md)
        echo "サービス名：$service"
        echo "ユーザー名：$username"
        echo "パスワード：$password"
      else
        echo "そのサービスは登録されていません。"
      fi
      ;;
    Exit)
      echo "Thank you!"
      break
      ;;
    *)
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      next=1
      ;;
  esac
done