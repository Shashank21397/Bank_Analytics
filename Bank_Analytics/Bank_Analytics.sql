create database bank_loan_analytics;
use bank_loan_analytics;

select * from finance_1;
select * from finance_2;


select count(*) from finance_1;
Select count(*) from finance_2;


/*
> Year wise loan amount.
> Grade-subgrade wise revoluation balance.
> Total Payment For Verified Status Vs Not-Verified Status.
> State Wise Last Credit pull_d wise Loan Status.
> Home Ownership Vs Last Payment Date Stats.
*/

#KPI 1 :  Year wise loan amount.
SELECT 
    YEAR(issue_d) as Year,
    CONCAT('₹ ', format(SUM(loan_amnt)/100000, 2), ' M') as 'Loan Amount'
FROM 
    finance_1
GROUP BY year(issue_d)
ORDER BY year(issue_d);


#KPI 2 :  Grade-subgrade wise revoluation balance.
SELECT 
    grade as Grade,
    sub_grade as 'Sub-Grade',
    CONCAT('₹ ', format(sum(revol_bal)/100000, 2), ' M') as 'Revolving Balance'
FROM 
    finance_1
JOIN 
    finance_2 ON finance_1.id = finance_2.id
GROUP BY grade,sub_grade
ORDER BY grade,sub_grade DESC;


#KPI 3 :Total Payment For Verified Status Vs Not-Verified Status.
SELECT 
    verification_status AS 'Verification Status',
    CONCAT('₹ ', FORMAT(SUM(total_pymnt)/1000000, 2), ' M') AS 'Total Payment Amount'
FROM 
    finance_1
JOIN 
    finance_2 ON finance_1.id = finance_2.id
WHERE 
    verification_status IN ('Verified', 'Not Verified')
GROUP BY 
    verification_status;
    
    
    #KPI4 : State Wise Last Credit pull_d wise Loan Status.
    SELECT 
    addr_state as 'State',
    monthname(issue_d) as 'Month',
    loan_status as 'Loan Status',
    count(id) as 'Count of Status'
FROM 
    finance_1
GROUP BY addr_state,monthname(issue_d),loan_status
ORDER BY count(id) DESC;


#KPI5 :  Home Ownership Vs Last Payment Date Stats.
SELECT  
    home_ownership AS 'Home Ownership',
    FORMAT(COUNT(last_pymnt_d), 0) AS 'Last Payment Date Stats'
FROM 
    finance_1
JOIN 
    finance_2 ON finance_1.id = finance_2.id
GROUP BY 
    home_ownership;