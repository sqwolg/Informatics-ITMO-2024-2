#!/bin/bash

decimal_to_binary() {
    local decimal=$1
    local binary=""
    
    for (( i=7; i>=0; i-- )); do
        local bit=$(( (decimal >> i) & 1 ))
        binary="${binary}${bit}"
    done
    
    echo "$binary"
}

echo "Введите IPv4-адрес в формате XXX.XXX.XXX.XXX:"
read ip_address

if ! [[ $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Ошибка: неверный формат IP-адреса"
    exit 1
fi

IFS='.' read -ra octets <<< "$ip_address"

binary_ip=""

for octet in "${octets[@]}"; do
    if [[ $octet -lt 0 || $octet -gt 255 ]]; then
        echo "Ошибка: неверный IP-адрес. Октет должен быть в диапазоне 0-255."
        exit 1
    fi
    
    binary_octet=$(decimal_to_binary $octet)
    
    if [ -z "$binary_ip" ]; then
        binary_ip="$binary_octet"
    else
        binary_ip="$binary_ip.$binary_octet"
    fi
done

echo "IPv4-адрес в двоичном формате:"
echo "$binary_ip"
