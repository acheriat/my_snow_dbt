with customer_orders as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        count(o.order_id) as total_orders,
        sum(o.order_amount) as total_amount
    from {{ source('work', 'customers') }} c
    left join {{ source('work', 'orders') }} o
        on c.customer_id = o.customer_id
    where o.status = 'completed'
    group by c.customer_id, c.first_name, c.last_name, c.country
)

select *
from customer_orders
