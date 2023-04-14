#init crontab silently if non-existant
crontab -l 2>/dev/null >/dev/null || echo -n "" | crontab - 

echo -n "How many nodes do you want to schedule (2-4)?"
read node_count

if [[ $node_count < 2 ]]; then
    echo "no need for a scheduler with just one node ;)"
    exit
fi

if [[ $node_count > 4 ]]; then
    echo "you need to run each node for 6 hours for max rewards, therefore you cannot run more than 4 on a single server"
    exit
fi

echo -n "Enter your first API key: "
read api_1

echo -n "Enter your second API key: "
read api_2

if [[ $node_count > 2 ]]; then
    echo -n "Enter your third API key: "
    read api_3
fi 

if [[ $node_count > 3 ]]; then
    echo -n "Enter your fourth API key: "
    read api_4
fi

if [[ $node_count == 2 ]]; then
    (crontab -l && echo "0 0 * * * echo $api_2 | myria-node --stop") | crontab -
    (crontab -l && echo "5 0 * * * echo $api_1 | myria-node --start") | crontab -
    (crontab -l && echo "0 12 * * * echo $api_1 | myria-node --stop") | crontab -
    (crontab -l && echo "5 12 * * * echo $api_2 | myria-node --start") | crontab -
fi 

if [[ $node_count == 3 ]]; then
    (crontab -l && echo "0 0 * * * echo $api_3 | myria-node --stop") | crontab -
    (crontab -l && echo "5 0 * * * echo $api_1 | myria-node --start") | crontab -
    (crontab -l && echo "0 8 * * * echo $api_1 | myria-node --stop") | crontab -
    (crontab -l && echo "5 8 * * * echo $api_2 | myria-node --start") | crontab -
    (crontab -l && echo "0 16 * * * echo $api_2 | myria-node --stop") | crontab -
    (crontab -l && echo "5 16 * * * echo $api_3 | myria-node --start") | crontab -
fi 

if [[ $node_count == 4 ]]; then
    (crontab -l && echo "0 0 * * * echo $api_4 | myria-node --stop") | crontab -
    (crontab -l && echo "1 0 * * * echo $api_1 | myria-node --start") | crontab -
    (crontab -l && echo "0 6 * * * echo $api_1 | myria-node --stop") | crontab -
    (crontab -l && echo "1 6 * * * echo $api_2 | myria-node --start") | crontab -
    (crontab -l && echo "0 12 * * * echo $api_2 | myria-node --stop") | crontab -
    (crontab -l && echo "1 12 * * * echo $api_3 | myria-node --start") | crontab -
    (crontab -l && echo "0 18 * * * echo $api_4 | myria-node --stop") | crontab -
    (crontab -l && echo "1 18 * * * echo $api_4 | myria-node --start") | crontab -
fi 