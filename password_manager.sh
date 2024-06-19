echo "パスワードマネージャーへようこそ！"
next=1

for i in {1..2}
do
  if [ $next -eq 1 ]; then
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
  fi
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
      ;;
    Get\ Password)
      echo "開発中"
      ;;
    Exit)
      echo "Thank you!"
      break
      ;;
    *)
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      next=0
      ;;
  esac
done