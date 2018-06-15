package com.mrbt.yeston.web.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class YtMoneyFlowExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    protected Integer pageNo = 1;

    protected Integer startRow;

    protected Integer pageSize = 10;

    protected String fields;

    public YtMoneyFlowExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo=pageNo;
        this.startRow = (pageNo-1)*this.pageSize;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setStartRow(Integer startRow) {
        this.startRow=startRow;
    }

    public Integer getStartRow() {
        return startRow;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize=pageSize;
        this.startRow = (pageNo-1)*this.pageSize;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setFields(String fields) {
        this.fields=fields;
    }

    public String getFields() {
        return fields;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(String value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(String value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(String value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(String value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(String value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(String value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLike(String value) {
            addCriterion("id like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotLike(String value) {
            addCriterion("id not like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<String> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<String> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(String value1, String value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(String value1, String value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdIsNull() {
            addCriterion("car_loan_id is null");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdIsNotNull() {
            addCriterion("car_loan_id is not null");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdEqualTo(String value) {
            addCriterion("car_loan_id =", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdNotEqualTo(String value) {
            addCriterion("car_loan_id <>", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdGreaterThan(String value) {
            addCriterion("car_loan_id >", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdGreaterThanOrEqualTo(String value) {
            addCriterion("car_loan_id >=", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdLessThan(String value) {
            addCriterion("car_loan_id <", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdLessThanOrEqualTo(String value) {
            addCriterion("car_loan_id <=", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdLike(String value) {
            addCriterion("car_loan_id like", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdNotLike(String value) {
            addCriterion("car_loan_id not like", value, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdIn(List<String> values) {
            addCriterion("car_loan_id in", values, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdNotIn(List<String> values) {
            addCriterion("car_loan_id not in", values, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdBetween(String value1, String value2) {
            addCriterion("car_loan_id between", value1, value2, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andCarLoanIdNotBetween(String value1, String value2) {
            addCriterion("car_loan_id not between", value1, value2, "carLoanId");
            return (Criteria) this;
        }

        public Criteria andTaskNameIsNull() {
            addCriterion("task_name is null");
            return (Criteria) this;
        }

        public Criteria andTaskNameIsNotNull() {
            addCriterion("task_name is not null");
            return (Criteria) this;
        }

        public Criteria andTaskNameEqualTo(String value) {
            addCriterion("task_name =", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameNotEqualTo(String value) {
            addCriterion("task_name <>", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameGreaterThan(String value) {
            addCriterion("task_name >", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameGreaterThanOrEqualTo(String value) {
            addCriterion("task_name >=", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameLessThan(String value) {
            addCriterion("task_name <", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameLessThanOrEqualTo(String value) {
            addCriterion("task_name <=", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameLike(String value) {
            addCriterion("task_name like", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameNotLike(String value) {
            addCriterion("task_name not like", value, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameIn(List<String> values) {
            addCriterion("task_name in", values, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameNotIn(List<String> values) {
            addCriterion("task_name not in", values, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameBetween(String value1, String value2) {
            addCriterion("task_name between", value1, value2, "taskName");
            return (Criteria) this;
        }

        public Criteria andTaskNameNotBetween(String value1, String value2) {
            addCriterion("task_name not between", value1, value2, "taskName");
            return (Criteria) this;
        }

        public Criteria andUIdIsNull() {
            addCriterion("u_id is null");
            return (Criteria) this;
        }

        public Criteria andUIdIsNotNull() {
            addCriterion("u_id is not null");
            return (Criteria) this;
        }

        public Criteria andUIdEqualTo(Integer value) {
            addCriterion("u_id =", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotEqualTo(Integer value) {
            addCriterion("u_id <>", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdGreaterThan(Integer value) {
            addCriterion("u_id >", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("u_id >=", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdLessThan(Integer value) {
            addCriterion("u_id <", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdLessThanOrEqualTo(Integer value) {
            addCriterion("u_id <=", value, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdIn(List<Integer> values) {
            addCriterion("u_id in", values, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotIn(List<Integer> values) {
            addCriterion("u_id not in", values, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdBetween(Integer value1, Integer value2) {
            addCriterion("u_id between", value1, value2, "uId");
            return (Criteria) this;
        }

        public Criteria andUIdNotBetween(Integer value1, Integer value2) {
            addCriterion("u_id not between", value1, value2, "uId");
            return (Criteria) this;
        }

        public Criteria andFromAccountIsNull() {
            addCriterion("from_account is null");
            return (Criteria) this;
        }

        public Criteria andFromAccountIsNotNull() {
            addCriterion("from_account is not null");
            return (Criteria) this;
        }

        public Criteria andFromAccountEqualTo(String value) {
            addCriterion("from_account =", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountNotEqualTo(String value) {
            addCriterion("from_account <>", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountGreaterThan(String value) {
            addCriterion("from_account >", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountGreaterThanOrEqualTo(String value) {
            addCriterion("from_account >=", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountLessThan(String value) {
            addCriterion("from_account <", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountLessThanOrEqualTo(String value) {
            addCriterion("from_account <=", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountLike(String value) {
            addCriterion("from_account like", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountNotLike(String value) {
            addCriterion("from_account not like", value, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountIn(List<String> values) {
            addCriterion("from_account in", values, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountNotIn(List<String> values) {
            addCriterion("from_account not in", values, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountBetween(String value1, String value2) {
            addCriterion("from_account between", value1, value2, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountNotBetween(String value1, String value2) {
            addCriterion("from_account not between", value1, value2, "fromAccount");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameIsNull() {
            addCriterion("from_account_name is null");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameIsNotNull() {
            addCriterion("from_account_name is not null");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameEqualTo(String value) {
            addCriterion("from_account_name =", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameNotEqualTo(String value) {
            addCriterion("from_account_name <>", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameGreaterThan(String value) {
            addCriterion("from_account_name >", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameGreaterThanOrEqualTo(String value) {
            addCriterion("from_account_name >=", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameLessThan(String value) {
            addCriterion("from_account_name <", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameLessThanOrEqualTo(String value) {
            addCriterion("from_account_name <=", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameLike(String value) {
            addCriterion("from_account_name like", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameNotLike(String value) {
            addCriterion("from_account_name not like", value, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameIn(List<String> values) {
            addCriterion("from_account_name in", values, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameNotIn(List<String> values) {
            addCriterion("from_account_name not in", values, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameBetween(String value1, String value2) {
            addCriterion("from_account_name between", value1, value2, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountNameNotBetween(String value1, String value2) {
            addCriterion("from_account_name not between", value1, value2, "fromAccountName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameIsNull() {
            addCriterion("from_account_bank_name is null");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameIsNotNull() {
            addCriterion("from_account_bank_name is not null");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameEqualTo(String value) {
            addCriterion("from_account_bank_name =", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameNotEqualTo(String value) {
            addCriterion("from_account_bank_name <>", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameGreaterThan(String value) {
            addCriterion("from_account_bank_name >", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameGreaterThanOrEqualTo(String value) {
            addCriterion("from_account_bank_name >=", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameLessThan(String value) {
            addCriterion("from_account_bank_name <", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameLessThanOrEqualTo(String value) {
            addCriterion("from_account_bank_name <=", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameLike(String value) {
            addCriterion("from_account_bank_name like", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameNotLike(String value) {
            addCriterion("from_account_bank_name not like", value, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameIn(List<String> values) {
            addCriterion("from_account_bank_name in", values, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameNotIn(List<String> values) {
            addCriterion("from_account_bank_name not in", values, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameBetween(String value1, String value2) {
            addCriterion("from_account_bank_name between", value1, value2, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andFromAccountBankNameNotBetween(String value1, String value2) {
            addCriterion("from_account_bank_name not between", value1, value2, "fromAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountIsNull() {
            addCriterion("to_account is null");
            return (Criteria) this;
        }

        public Criteria andToAccountIsNotNull() {
            addCriterion("to_account is not null");
            return (Criteria) this;
        }

        public Criteria andToAccountEqualTo(String value) {
            addCriterion("to_account =", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountNotEqualTo(String value) {
            addCriterion("to_account <>", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountGreaterThan(String value) {
            addCriterion("to_account >", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountGreaterThanOrEqualTo(String value) {
            addCriterion("to_account >=", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountLessThan(String value) {
            addCriterion("to_account <", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountLessThanOrEqualTo(String value) {
            addCriterion("to_account <=", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountLike(String value) {
            addCriterion("to_account like", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountNotLike(String value) {
            addCriterion("to_account not like", value, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountIn(List<String> values) {
            addCriterion("to_account in", values, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountNotIn(List<String> values) {
            addCriterion("to_account not in", values, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountBetween(String value1, String value2) {
            addCriterion("to_account between", value1, value2, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountNotBetween(String value1, String value2) {
            addCriterion("to_account not between", value1, value2, "toAccount");
            return (Criteria) this;
        }

        public Criteria andToAccountNameIsNull() {
            addCriterion("to_account_name is null");
            return (Criteria) this;
        }

        public Criteria andToAccountNameIsNotNull() {
            addCriterion("to_account_name is not null");
            return (Criteria) this;
        }

        public Criteria andToAccountNameEqualTo(String value) {
            addCriterion("to_account_name =", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameNotEqualTo(String value) {
            addCriterion("to_account_name <>", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameGreaterThan(String value) {
            addCriterion("to_account_name >", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameGreaterThanOrEqualTo(String value) {
            addCriterion("to_account_name >=", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameLessThan(String value) {
            addCriterion("to_account_name <", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameLessThanOrEqualTo(String value) {
            addCriterion("to_account_name <=", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameLike(String value) {
            addCriterion("to_account_name like", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameNotLike(String value) {
            addCriterion("to_account_name not like", value, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameIn(List<String> values) {
            addCriterion("to_account_name in", values, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameNotIn(List<String> values) {
            addCriterion("to_account_name not in", values, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameBetween(String value1, String value2) {
            addCriterion("to_account_name between", value1, value2, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountNameNotBetween(String value1, String value2) {
            addCriterion("to_account_name not between", value1, value2, "toAccountName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameIsNull() {
            addCriterion("to_account_bank_name is null");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameIsNotNull() {
            addCriterion("to_account_bank_name is not null");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameEqualTo(String value) {
            addCriterion("to_account_bank_name =", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameNotEqualTo(String value) {
            addCriterion("to_account_bank_name <>", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameGreaterThan(String value) {
            addCriterion("to_account_bank_name >", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameGreaterThanOrEqualTo(String value) {
            addCriterion("to_account_bank_name >=", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameLessThan(String value) {
            addCriterion("to_account_bank_name <", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameLessThanOrEqualTo(String value) {
            addCriterion("to_account_bank_name <=", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameLike(String value) {
            addCriterion("to_account_bank_name like", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameNotLike(String value) {
            addCriterion("to_account_bank_name not like", value, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameIn(List<String> values) {
            addCriterion("to_account_bank_name in", values, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameNotIn(List<String> values) {
            addCriterion("to_account_bank_name not in", values, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameBetween(String value1, String value2) {
            addCriterion("to_account_bank_name between", value1, value2, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andToAccountBankNameNotBetween(String value1, String value2) {
            addCriterion("to_account_bank_name not between", value1, value2, "toAccountBankName");
            return (Criteria) this;
        }

        public Criteria andMoneyIsNull() {
            addCriterion("money is null");
            return (Criteria) this;
        }

        public Criteria andMoneyIsNotNull() {
            addCriterion("money is not null");
            return (Criteria) this;
        }

        public Criteria andMoneyEqualTo(Double value) {
            addCriterion("money =", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyNotEqualTo(Double value) {
            addCriterion("money <>", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyGreaterThan(Double value) {
            addCriterion("money >", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyGreaterThanOrEqualTo(Double value) {
            addCriterion("money >=", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyLessThan(Double value) {
            addCriterion("money <", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyLessThanOrEqualTo(Double value) {
            addCriterion("money <=", value, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyIn(List<Double> values) {
            addCriterion("money in", values, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyNotIn(List<Double> values) {
            addCriterion("money not in", values, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyBetween(Double value1, Double value2) {
            addCriterion("money between", value1, value2, "money");
            return (Criteria) this;
        }

        public Criteria andMoneyNotBetween(Double value1, Double value2) {
            addCriterion("money not between", value1, value2, "money");
            return (Criteria) this;
        }

        public Criteria andAddTimeIsNull() {
            addCriterion("add_time is null");
            return (Criteria) this;
        }

        public Criteria andAddTimeIsNotNull() {
            addCriterion("add_time is not null");
            return (Criteria) this;
        }

        public Criteria andAddTimeEqualTo(Date value) {
            addCriterion("add_time =", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeNotEqualTo(Date value) {
            addCriterion("add_time <>", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeGreaterThan(Date value) {
            addCriterion("add_time >", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("add_time >=", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeLessThan(Date value) {
            addCriterion("add_time <", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeLessThanOrEqualTo(Date value) {
            addCriterion("add_time <=", value, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeIn(List<Date> values) {
            addCriterion("add_time in", values, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeNotIn(List<Date> values) {
            addCriterion("add_time not in", values, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeBetween(Date value1, Date value2) {
            addCriterion("add_time between", value1, value2, "addTime");
            return (Criteria) this;
        }

        public Criteria andAddTimeNotBetween(Date value1, Date value2) {
            addCriterion("add_time not between", value1, value2, "addTime");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}