CREATE VIEW vw_all_users_data as
WITH address_with_city AS (
    SELECT cities.name AS city, cities.state AS state, public_place AS street, number AS number,
    zip_code AS zip, investor_id
      FROM addresses
    LEFT JOIN cities on cities.id = city_id --junta cidades com endereço
  ),
  investor_data AS (
    select investors.id, type, full_name AS name, email, mother_full_name AS mother,
    city_code AS areacode, phone_number AS phone, document, cpf, birth_date
      from investors
    left join users on users.id = user_id --junta usuário com investidor
    left join users_type on users_type.id = user_type_id --junta usuário com user_type
    left join phones on phones.investor_id = investors.id --junta phone com investidor
  )
  SELECT investor_data.id, investor_data.type, name, birth_date, document, cpf, email, mother, state, city, street, number, zip, areacode, phone
    FROM investor_data
  LEFT JOIN address_with_city on investor_data.id = investor_id;
  
  SELECT name FROM vw_all_users_data WHERE id = 4;
  
  