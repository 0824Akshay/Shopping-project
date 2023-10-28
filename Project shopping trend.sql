select * from project.shopping_trends;

/*1.Shopping trend for men v women*/
select * from project.shopping_trends where gender='male';
select count(gender) as gender_male from project.shopping_trends where gender='male';
select * from project.shopping_trends where gender='female';
select count(gender) as gender_female from project.shopping_trends where gender='female';

/*2.Top 2 items purchased max. times by men v women*/
select category, count(category) as category_count_male from project.shopping_trends 
where gender='male'  group by category order by category desc limit 2;
select category, count(category) as category_count_female from project.shopping_trends 
where gender='female'  group by category order by category desc limit 2;

/*3.Seasons they went in shopping-men v women*/
select season, count(season) as season_count_male from project.shopping_trends 
where gender='male'  group by season order by season_count_male desc limit 2;
select category, count(category) as season_count_female from project.shopping_trends 
where gender='female'  group by season order by season_count_female desc limit 2;

/*4.Category most purchased season wise*/
select season, category from(select season, category, count(category) as most_purchased_per_season, row_number() 
over (partition by season order by count(category) desc) as rn from project.shopping_trends group by season,category) as ranked where rn=1;

/*5.Payment method most used category wise*/
/*5.1. Calculating the most used payment method*/
select preferred_payment_method, count(preferred_payment_method) from project. shopping_trends 
group by preferred_payment_method order by Preferred_Payment_Method desc;

/*5.2 Calculating the most used payment method category wise*/
select preferred_payment_method,category from(select preferred_payment_method, category, count(category) as most_used_payment_method, row_number()
over (partition by category order by count(category) desc) as rm
from project.shopping_trends group by preferred_payment_method, category) as ranked where rm=1;

/*6.Who applied discounts max.times-men or women*/
select discount_applied, count(discount_applied) as  discoiunt_applied_men from project.shopping_trends 
where gender='male' group by discount_applied;
select discount_applied, count(discount_applied) as discount_applied_women from project.shopping_trends 
where gender='female' group by discount_applied;

/*7.Category where discount applied is max.*/
select t.gender, t.category, count(t.category) as category_discount from project.shopping_trends t join(
select gender, max(discount_applied) as max_discount_applied from project.shopping_trends group by gender) 
as max_discounts on t.gender=max_discounts.gender and t.discount=max_discounts.max_discount
group by t.gender,t.category;

