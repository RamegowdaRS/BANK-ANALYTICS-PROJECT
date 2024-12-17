
create database Bank_loan;
use bank_loan;

select * from Bank_Analytics_Dataset;

# KPI 1 (YEAR WISE LOAN AMOUNT STATS) 
select year(issue_d) as loan_year,date_format(issue_d, '%M') as loan_month,sum(loan_amnt) as total_loan_amount,
avg(loan_amnt) as average_loan_amount 
from Bank_Analytics_Dataset
group by loan_year, loan_month 
order by total_loan_amount ;


# KPI 2 (GRADE AND SUB GRADE WISE REVOL_BAL) 
Select grade, sub_grade,sum(revol_bal) as total_revol_bal
from Bank_Analytics_Dataset
group by grade, sub_grade 
order by grade, sub_grade;


# KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status) 
select verification_status, round(sum(total_pymnt),2) as Total_payment
from finance_1 f1 inner join finance_2 f2 
on(f1.id = f2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

Select verification_status,sum(loan_amnt) as total_loan_amount
from Bank_Analytics_Dataset
group by verification_status 
order by verification_status;


# KPI 4 (State wise and last_credit_pull_d wise loan status) 
Select addr_state,last_credit_pull_d,loan_status,count(*) as status_count
from Bank_Analytics_Dataset 
group by addr_state, last_credit_pull_d, loan_status 
order by addr_state, last_credit_pull_d;

# KPI 5 (Home ownership Vs last payment date stats)           
Select home_ownership,last_pymnt_d,count(*) as loan_count
from Bank_Analytics_Dataset 
group by home_ownership, last_pymnt_d 
order by home_ownership, last_pymnt_d;






