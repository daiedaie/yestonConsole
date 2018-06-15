package com.mrbt.yeston.web.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class YtCarLoanLogExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    protected Integer pageNo = 1;

    protected Integer startRow;

    protected Integer pageSize = 10;

    protected String fields;

    public YtCarLoanLogExample() {
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

        protected void addCriterionForJDBCDate(String condition, Date value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value.getTime()), property);
        }

        protected void addCriterionForJDBCDate(String condition, List<Date> values, String property) {
            if (values == null || values.size() == 0) {
                throw new RuntimeException("Value list for " + property + " cannot be null or empty");
            }
            List<java.sql.Date> dateList = new ArrayList<java.sql.Date>();
            Iterator<Date> iter = values.iterator();
            while (iter.hasNext()) {
                dateList.add(new java.sql.Date(iter.next().getTime()));
            }
            addCriterion(condition, dateList, property);
        }

        protected void addCriterionForJDBCDate(String condition, Date value1, Date value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            addCriterion(condition, new java.sql.Date(value1.getTime()), new java.sql.Date(value2.getTime()), property);
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andStatusIsNull() {
            addCriterion("status is null");
            return (Criteria) this;
        }

        public Criteria andStatusIsNotNull() {
            addCriterion("status is not null");
            return (Criteria) this;
        }

        public Criteria andStatusEqualTo(Integer value) {
            addCriterion("status =", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotEqualTo(Integer value) {
            addCriterion("status <>", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThan(Integer value) {
            addCriterion("status >", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusGreaterThanOrEqualTo(Integer value) {
            addCriterion("status >=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThan(Integer value) {
            addCriterion("status <", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusLessThanOrEqualTo(Integer value) {
            addCriterion("status <=", value, "status");
            return (Criteria) this;
        }

        public Criteria andStatusIn(List<Integer> values) {
            addCriterion("status in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotIn(List<Integer> values) {
            addCriterion("status not in", values, "status");
            return (Criteria) this;
        }

        public Criteria andStatusBetween(Integer value1, Integer value2) {
            addCriterion("status between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andStatusNotBetween(Integer value1, Integer value2) {
            addCriterion("status not between", value1, value2, "status");
            return (Criteria) this;
        }

        public Criteria andOperInfoIsNull() {
            addCriterion("oper_info is null");
            return (Criteria) this;
        }

        public Criteria andOperInfoIsNotNull() {
            addCriterion("oper_info is not null");
            return (Criteria) this;
        }

        public Criteria andOperInfoEqualTo(String value) {
            addCriterion("oper_info =", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoNotEqualTo(String value) {
            addCriterion("oper_info <>", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoGreaterThan(String value) {
            addCriterion("oper_info >", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoGreaterThanOrEqualTo(String value) {
            addCriterion("oper_info >=", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoLessThan(String value) {
            addCriterion("oper_info <", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoLessThanOrEqualTo(String value) {
            addCriterion("oper_info <=", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoLike(String value) {
            addCriterion("oper_info like", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoNotLike(String value) {
            addCriterion("oper_info not like", value, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoIn(List<String> values) {
            addCriterion("oper_info in", values, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoNotIn(List<String> values) {
            addCriterion("oper_info not in", values, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoBetween(String value1, String value2) {
            addCriterion("oper_info between", value1, value2, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperInfoNotBetween(String value1, String value2) {
            addCriterion("oper_info not between", value1, value2, "operInfo");
            return (Criteria) this;
        }

        public Criteria andOperTimeIsNull() {
            addCriterion("oper_time is null");
            return (Criteria) this;
        }

        public Criteria andOperTimeIsNotNull() {
            addCriterion("oper_time is not null");
            return (Criteria) this;
        }

        public Criteria andOperTimeEqualTo(Date value) {
            addCriterionForJDBCDate("oper_time =", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeNotEqualTo(Date value) {
            addCriterionForJDBCDate("oper_time <>", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeGreaterThan(Date value) {
            addCriterionForJDBCDate("oper_time >", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeGreaterThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("oper_time >=", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeLessThan(Date value) {
            addCriterionForJDBCDate("oper_time <", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeLessThanOrEqualTo(Date value) {
            addCriterionForJDBCDate("oper_time <=", value, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeIn(List<Date> values) {
            addCriterionForJDBCDate("oper_time in", values, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeNotIn(List<Date> values) {
            addCriterionForJDBCDate("oper_time not in", values, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("oper_time between", value1, value2, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperTimeNotBetween(Date value1, Date value2) {
            addCriterionForJDBCDate("oper_time not between", value1, value2, "operTime");
            return (Criteria) this;
        }

        public Criteria andOperUserIdIsNull() {
            addCriterion("oper_user_id is null");
            return (Criteria) this;
        }

        public Criteria andOperUserIdIsNotNull() {
            addCriterion("oper_user_id is not null");
            return (Criteria) this;
        }

        public Criteria andOperUserIdEqualTo(Integer value) {
            addCriterion("oper_user_id =", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdNotEqualTo(Integer value) {
            addCriterion("oper_user_id <>", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdGreaterThan(Integer value) {
            addCriterion("oper_user_id >", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("oper_user_id >=", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdLessThan(Integer value) {
            addCriterion("oper_user_id <", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("oper_user_id <=", value, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdIn(List<Integer> values) {
            addCriterion("oper_user_id in", values, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdNotIn(List<Integer> values) {
            addCriterion("oper_user_id not in", values, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdBetween(Integer value1, Integer value2) {
            addCriterion("oper_user_id between", value1, value2, "operUserId");
            return (Criteria) this;
        }

        public Criteria andOperUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("oper_user_id not between", value1, value2, "operUserId");
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

        public Criteria andVoucherIsNull() {
            addCriterion("voucher is null");
            return (Criteria) this;
        }

        public Criteria andVoucherIsNotNull() {
            addCriterion("voucher is not null");
            return (Criteria) this;
        }

        public Criteria andVoucherEqualTo(String value) {
            addCriterion("voucher =", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherNotEqualTo(String value) {
            addCriterion("voucher <>", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherGreaterThan(String value) {
            addCriterion("voucher >", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherGreaterThanOrEqualTo(String value) {
            addCriterion("voucher >=", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherLessThan(String value) {
            addCriterion("voucher <", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherLessThanOrEqualTo(String value) {
            addCriterion("voucher <=", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherLike(String value) {
            addCriterion("voucher like", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherNotLike(String value) {
            addCriterion("voucher not like", value, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherIn(List<String> values) {
            addCriterion("voucher in", values, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherNotIn(List<String> values) {
            addCriterion("voucher not in", values, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherBetween(String value1, String value2) {
            addCriterion("voucher between", value1, value2, "voucher");
            return (Criteria) this;
        }

        public Criteria andVoucherNotBetween(String value1, String value2) {
            addCriterion("voucher not between", value1, value2, "voucher");
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