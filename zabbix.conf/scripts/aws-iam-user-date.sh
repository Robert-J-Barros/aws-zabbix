#!/bin/bash

# Obtém a data atual em formato Unix (em segundos)
current_date=$(date +%s)

# Obtém a lista de todos os usuários IAM
users=$(aws iam list-users --output json | jq -r '.Users[] | .UserName')

# Inicializa a contagem de usuários com senhas mais velhas que 60 dias
old_password_users_count=0

# Loop sobre cada usuário
for user in $users; do
    # Obtém a data da última vez que a senha foi alterada
    password_last_used=$(aws iam get-user --user-name "$user" --output json | jq -r '.User.PasswordLastUsed')

    # Verifica se a senha já foi usada (PasswordLastUsed pode ser null)
    if [ "$password_last_used" != "null" ] && [ -n "$password_last_used" ]; then
        # Converte a data para formato Unix
        password_last_used_unix=$(date -d "$password_last_used" +%s)
        # Calcula a diferença em dias
        days_since_password_used=$(( (current_date - password_last_used_unix) / (60*60*24) ))

        # Verifica se a senha tem mais de 60 dias
        if [ "$days_since_password_used" -gt 60 ]; then
            old_password_users_count=$((old_password_users_count + 1))
        fi
    fi
done

# Exibe o número de usuários com senhas mais velhas que 60 dias
echo $old_password_users_count
