if [ "$(date +%w)" -eq $DAY_OF_WEEK ] 
then
  echo "HELLO!"
fi

# Rotate backups once a month
if [ $DAY_OF_MONTH -eq 23 ] 
then
  echo "HELLO2"
fi