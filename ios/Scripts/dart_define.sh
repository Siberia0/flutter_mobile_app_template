#/bin/bash
function copyFile() {
    if [ "$1" == "product" ]; then
      firebase_type="prd"
    else
      firebase_type="dev"
    fi

    echo "#include \"$firebase_type.xcconfi\"" > $SRCROOT/Flutter/DartDefine.xcconfig
}

echo $DART_DEFINES | tr ',' '\n' | while read line;
do
  echo $line | base64 -d | tr ',' '\n' | xargs -I@ bash -c "echo @ | grep 'OPERATION_TYPE' | sed 's/.*=//'"
done | {
  read operation_type
  copyFile $operation_type
}