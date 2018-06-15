package com.mrbt.yeston.web.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class YtCarLoanExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    protected Integer pageNo = 1;

    protected Integer startRow;

    protected Integer pageSize = 10;

    protected String fields;

    public YtCarLoanExample() {
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

        public Criteria andPlateNumberIsNull() {
            addCriterion("plate_number is null");
            return (Criteria) this;
        }

        public Criteria andPlateNumberIsNotNull() {
            addCriterion("plate_number is not null");
            return (Criteria) this;
        }

        public Criteria andPlateNumberEqualTo(String value) {
            addCriterion("plate_number =", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberNotEqualTo(String value) {
            addCriterion("plate_number <>", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberGreaterThan(String value) {
            addCriterion("plate_number >", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberGreaterThanOrEqualTo(String value) {
            addCriterion("plate_number >=", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberLessThan(String value) {
            addCriterion("plate_number <", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberLessThanOrEqualTo(String value) {
            addCriterion("plate_number <=", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberLike(String value) {
            addCriterion("plate_number like", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberNotLike(String value) {
            addCriterion("plate_number not like", value, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberIn(List<String> values) {
            addCriterion("plate_number in", values, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberNotIn(List<String> values) {
            addCriterion("plate_number not in", values, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberBetween(String value1, String value2) {
            addCriterion("plate_number between", value1, value2, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andPlateNumberNotBetween(String value1, String value2) {
            addCriterion("plate_number not between", value1, value2, "plateNumber");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipIsNull() {
            addCriterion("vehicle_ownership is null");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipIsNotNull() {
            addCriterion("vehicle_ownership is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipEqualTo(Integer value) {
            addCriterion("vehicle_ownership =", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipNotEqualTo(Integer value) {
            addCriterion("vehicle_ownership <>", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipGreaterThan(Integer value) {
            addCriterion("vehicle_ownership >", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipGreaterThanOrEqualTo(Integer value) {
            addCriterion("vehicle_ownership >=", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipLessThan(Integer value) {
            addCriterion("vehicle_ownership <", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipLessThanOrEqualTo(Integer value) {
            addCriterion("vehicle_ownership <=", value, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipIn(List<Integer> values) {
            addCriterion("vehicle_ownership in", values, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipNotIn(List<Integer> values) {
            addCriterion("vehicle_ownership not in", values, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipBetween(Integer value1, Integer value2) {
            addCriterion("vehicle_ownership between", value1, value2, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andVehicleOwnershipNotBetween(Integer value1, Integer value2) {
            addCriterion("vehicle_ownership not between", value1, value2, "vehicleOwnership");
            return (Criteria) this;
        }

        public Criteria andOwnerNameIsNull() {
            addCriterion("owner_name is null");
            return (Criteria) this;
        }

        public Criteria andOwnerNameIsNotNull() {
            addCriterion("owner_name is not null");
            return (Criteria) this;
        }

        public Criteria andOwnerNameEqualTo(String value) {
            addCriterion("owner_name =", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameNotEqualTo(String value) {
            addCriterion("owner_name <>", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameGreaterThan(String value) {
            addCriterion("owner_name >", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameGreaterThanOrEqualTo(String value) {
            addCriterion("owner_name >=", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameLessThan(String value) {
            addCriterion("owner_name <", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameLessThanOrEqualTo(String value) {
            addCriterion("owner_name <=", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameLike(String value) {
            addCriterion("owner_name like", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameNotLike(String value) {
            addCriterion("owner_name not like", value, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameIn(List<String> values) {
            addCriterion("owner_name in", values, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameNotIn(List<String> values) {
            addCriterion("owner_name not in", values, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameBetween(String value1, String value2) {
            addCriterion("owner_name between", value1, value2, "ownerName");
            return (Criteria) this;
        }

        public Criteria andOwnerNameNotBetween(String value1, String value2) {
            addCriterion("owner_name not between", value1, value2, "ownerName");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationIsNull() {
            addCriterion("whether_operation is null");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationIsNotNull() {
            addCriterion("whether_operation is not null");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationEqualTo(Integer value) {
            addCriterion("whether_operation =", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationNotEqualTo(Integer value) {
            addCriterion("whether_operation <>", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationGreaterThan(Integer value) {
            addCriterion("whether_operation >", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationGreaterThanOrEqualTo(Integer value) {
            addCriterion("whether_operation >=", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationLessThan(Integer value) {
            addCriterion("whether_operation <", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationLessThanOrEqualTo(Integer value) {
            addCriterion("whether_operation <=", value, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationIn(List<Integer> values) {
            addCriterion("whether_operation in", values, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationNotIn(List<Integer> values) {
            addCriterion("whether_operation not in", values, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationBetween(Integer value1, Integer value2) {
            addCriterion("whether_operation between", value1, value2, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andWhetherOperationNotBetween(Integer value1, Integer value2) {
            addCriterion("whether_operation not between", value1, value2, "whetherOperation");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeIsNull() {
            addCriterion("vehicle_type is null");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeIsNotNull() {
            addCriterion("vehicle_type is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeEqualTo(String value) {
            addCriterion("vehicle_type =", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeNotEqualTo(String value) {
            addCriterion("vehicle_type <>", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeGreaterThan(String value) {
            addCriterion("vehicle_type >", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeGreaterThanOrEqualTo(String value) {
            addCriterion("vehicle_type >=", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeLessThan(String value) {
            addCriterion("vehicle_type <", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeLessThanOrEqualTo(String value) {
            addCriterion("vehicle_type <=", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeLike(String value) {
            addCriterion("vehicle_type like", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeNotLike(String value) {
            addCriterion("vehicle_type not like", value, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeIn(List<String> values) {
            addCriterion("vehicle_type in", values, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeNotIn(List<String> values) {
            addCriterion("vehicle_type not in", values, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeBetween(String value1, String value2) {
            addCriterion("vehicle_type between", value1, value2, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleTypeNotBetween(String value1, String value2) {
            addCriterion("vehicle_type not between", value1, value2, "vehicleType");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeIsNull() {
            addCriterion("vehicle_life is null");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeIsNotNull() {
            addCriterion("vehicle_life is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeEqualTo(Integer value) {
            addCriterion("vehicle_life =", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeNotEqualTo(Integer value) {
            addCriterion("vehicle_life <>", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeGreaterThan(Integer value) {
            addCriterion("vehicle_life >", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeGreaterThanOrEqualTo(Integer value) {
            addCriterion("vehicle_life >=", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeLessThan(Integer value) {
            addCriterion("vehicle_life <", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeLessThanOrEqualTo(Integer value) {
            addCriterion("vehicle_life <=", value, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeIn(List<Integer> values) {
            addCriterion("vehicle_life in", values, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeNotIn(List<Integer> values) {
            addCriterion("vehicle_life not in", values, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeBetween(Integer value1, Integer value2) {
            addCriterion("vehicle_life between", value1, value2, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andVehicleLifeNotBetween(Integer value1, Integer value2) {
            addCriterion("vehicle_life not between", value1, value2, "vehicleLife");
            return (Criteria) this;
        }

        public Criteria andKilometersIsNull() {
            addCriterion("kilometers is null");
            return (Criteria) this;
        }

        public Criteria andKilometersIsNotNull() {
            addCriterion("kilometers is not null");
            return (Criteria) this;
        }

        public Criteria andKilometersEqualTo(Double value) {
            addCriterion("kilometers =", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersNotEqualTo(Double value) {
            addCriterion("kilometers <>", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersGreaterThan(Double value) {
            addCriterion("kilometers >", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersGreaterThanOrEqualTo(Double value) {
            addCriterion("kilometers >=", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersLessThan(Double value) {
            addCriterion("kilometers <", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersLessThanOrEqualTo(Double value) {
            addCriterion("kilometers <=", value, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersIn(List<Double> values) {
            addCriterion("kilometers in", values, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersNotIn(List<Double> values) {
            addCriterion("kilometers not in", values, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersBetween(Double value1, Double value2) {
            addCriterion("kilometers between", value1, value2, "kilometers");
            return (Criteria) this;
        }

        public Criteria andKilometersNotBetween(Double value1, Double value2) {
            addCriterion("kilometers not between", value1, value2, "kilometers");
            return (Criteria) this;
        }

        public Criteria andLoanAmountIsNull() {
            addCriterion("loan_amount is null");
            return (Criteria) this;
        }

        public Criteria andLoanAmountIsNotNull() {
            addCriterion("loan_amount is not null");
            return (Criteria) this;
        }

        public Criteria andLoanAmountEqualTo(Double value) {
            addCriterion("loan_amount =", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountNotEqualTo(Double value) {
            addCriterion("loan_amount <>", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountGreaterThan(Double value) {
            addCriterion("loan_amount >", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountGreaterThanOrEqualTo(Double value) {
            addCriterion("loan_amount >=", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountLessThan(Double value) {
            addCriterion("loan_amount <", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountLessThanOrEqualTo(Double value) {
            addCriterion("loan_amount <=", value, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountIn(List<Double> values) {
            addCriterion("loan_amount in", values, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountNotIn(List<Double> values) {
            addCriterion("loan_amount not in", values, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountBetween(Double value1, Double value2) {
            addCriterion("loan_amount between", value1, value2, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanAmountNotBetween(Double value1, Double value2) {
            addCriterion("loan_amount not between", value1, value2, "loanAmount");
            return (Criteria) this;
        }

        public Criteria andLoanTermIsNull() {
            addCriterion("loan_term is null");
            return (Criteria) this;
        }

        public Criteria andLoanTermIsNotNull() {
            addCriterion("loan_term is not null");
            return (Criteria) this;
        }

        public Criteria andLoanTermEqualTo(Integer value) {
            addCriterion("loan_term =", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermNotEqualTo(Integer value) {
            addCriterion("loan_term <>", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermGreaterThan(Integer value) {
            addCriterion("loan_term >", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermGreaterThanOrEqualTo(Integer value) {
            addCriterion("loan_term >=", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermLessThan(Integer value) {
            addCriterion("loan_term <", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermLessThanOrEqualTo(Integer value) {
            addCriterion("loan_term <=", value, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermIn(List<Integer> values) {
            addCriterion("loan_term in", values, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermNotIn(List<Integer> values) {
            addCriterion("loan_term not in", values, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermBetween(Integer value1, Integer value2) {
            addCriterion("loan_term between", value1, value2, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andLoanTermNotBetween(Integer value1, Integer value2) {
            addCriterion("loan_term not between", value1, value2, "loanTerm");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeIsNull() {
            addCriterion("single_double_charge is null");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeIsNotNull() {
            addCriterion("single_double_charge is not null");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeEqualTo(Integer value) {
            addCriterion("single_double_charge =", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeNotEqualTo(Integer value) {
            addCriterion("single_double_charge <>", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeGreaterThan(Integer value) {
            addCriterion("single_double_charge >", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeGreaterThanOrEqualTo(Integer value) {
            addCriterion("single_double_charge >=", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeLessThan(Integer value) {
            addCriterion("single_double_charge <", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeLessThanOrEqualTo(Integer value) {
            addCriterion("single_double_charge <=", value, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeIn(List<Integer> values) {
            addCriterion("single_double_charge in", values, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeNotIn(List<Integer> values) {
            addCriterion("single_double_charge not in", values, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeBetween(Integer value1, Integer value2) {
            addCriterion("single_double_charge between", value1, value2, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andSingleDoubleChargeNotBetween(Integer value1, Integer value2) {
            addCriterion("single_double_charge not between", value1, value2, "singleDoubleCharge");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberIsNull() {
            addCriterion("dollars_number is null");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberIsNotNull() {
            addCriterion("dollars_number is not null");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberEqualTo(Integer value) {
            addCriterion("dollars_number =", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberNotEqualTo(Integer value) {
            addCriterion("dollars_number <>", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberGreaterThan(Integer value) {
            addCriterion("dollars_number >", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberGreaterThanOrEqualTo(Integer value) {
            addCriterion("dollars_number >=", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberLessThan(Integer value) {
            addCriterion("dollars_number <", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberLessThanOrEqualTo(Integer value) {
            addCriterion("dollars_number <=", value, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberIn(List<Integer> values) {
            addCriterion("dollars_number in", values, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberNotIn(List<Integer> values) {
            addCriterion("dollars_number not in", values, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberBetween(Integer value1, Integer value2) {
            addCriterion("dollars_number between", value1, value2, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andDollarsNumberNotBetween(Integer value1, Integer value2) {
            addCriterion("dollars_number not between", value1, value2, "dollarsNumber");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameIsNull() {
            addCriterion("one_dollars_name is null");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameIsNotNull() {
            addCriterion("one_dollars_name is not null");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameEqualTo(String value) {
            addCriterion("one_dollars_name =", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameNotEqualTo(String value) {
            addCriterion("one_dollars_name <>", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameGreaterThan(String value) {
            addCriterion("one_dollars_name >", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameGreaterThanOrEqualTo(String value) {
            addCriterion("one_dollars_name >=", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameLessThan(String value) {
            addCriterion("one_dollars_name <", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameLessThanOrEqualTo(String value) {
            addCriterion("one_dollars_name <=", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameLike(String value) {
            addCriterion("one_dollars_name like", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameNotLike(String value) {
            addCriterion("one_dollars_name not like", value, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameIn(List<String> values) {
            addCriterion("one_dollars_name in", values, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameNotIn(List<String> values) {
            addCriterion("one_dollars_name not in", values, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameBetween(String value1, String value2) {
            addCriterion("one_dollars_name between", value1, value2, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andOneDollarsNameNotBetween(String value1, String value2) {
            addCriterion("one_dollars_name not between", value1, value2, "oneDollarsName");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodIsNull() {
            addCriterion("repayment_method is null");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodIsNotNull() {
            addCriterion("repayment_method is not null");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodEqualTo(Integer value) {
            addCriterion("repayment_method =", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodNotEqualTo(Integer value) {
            addCriterion("repayment_method <>", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodGreaterThan(Integer value) {
            addCriterion("repayment_method >", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodGreaterThanOrEqualTo(Integer value) {
            addCriterion("repayment_method >=", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodLessThan(Integer value) {
            addCriterion("repayment_method <", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodLessThanOrEqualTo(Integer value) {
            addCriterion("repayment_method <=", value, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodIn(List<Integer> values) {
            addCriterion("repayment_method in", values, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodNotIn(List<Integer> values) {
            addCriterion("repayment_method not in", values, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodBetween(Integer value1, Integer value2) {
            addCriterion("repayment_method between", value1, value2, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRepaymentMethodNotBetween(Integer value1, Integer value2) {
            addCriterion("repayment_method not between", value1, value2, "repaymentMethod");
            return (Criteria) this;
        }

        public Criteria andRateIsNull() {
            addCriterion("rate is null");
            return (Criteria) this;
        }

        public Criteria andRateIsNotNull() {
            addCriterion("rate is not null");
            return (Criteria) this;
        }

        public Criteria andRateEqualTo(Double value) {
            addCriterion("rate =", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateNotEqualTo(Double value) {
            addCriterion("rate <>", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateGreaterThan(Double value) {
            addCriterion("rate >", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateGreaterThanOrEqualTo(Double value) {
            addCriterion("rate >=", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateLessThan(Double value) {
            addCriterion("rate <", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateLessThanOrEqualTo(Double value) {
            addCriterion("rate <=", value, "rate");
            return (Criteria) this;
        }

        public Criteria andRateIn(List<Double> values) {
            addCriterion("rate in", values, "rate");
            return (Criteria) this;
        }

        public Criteria andRateNotIn(List<Double> values) {
            addCriterion("rate not in", values, "rate");
            return (Criteria) this;
        }

        public Criteria andRateBetween(Double value1, Double value2) {
            addCriterion("rate between", value1, value2, "rate");
            return (Criteria) this;
        }

        public Criteria andRateNotBetween(Double value1, Double value2) {
            addCriterion("rate not between", value1, value2, "rate");
            return (Criteria) this;
        }

        public Criteria andTravelBookIsNull() {
            addCriterion("travel_book is null");
            return (Criteria) this;
        }

        public Criteria andTravelBookIsNotNull() {
            addCriterion("travel_book is not null");
            return (Criteria) this;
        }

        public Criteria andTravelBookEqualTo(String value) {
            addCriterion("travel_book =", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookNotEqualTo(String value) {
            addCriterion("travel_book <>", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookGreaterThan(String value) {
            addCriterion("travel_book >", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookGreaterThanOrEqualTo(String value) {
            addCriterion("travel_book >=", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookLessThan(String value) {
            addCriterion("travel_book <", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookLessThanOrEqualTo(String value) {
            addCriterion("travel_book <=", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookLike(String value) {
            addCriterion("travel_book like", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookNotLike(String value) {
            addCriterion("travel_book not like", value, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookIn(List<String> values) {
            addCriterion("travel_book in", values, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookNotIn(List<String> values) {
            addCriterion("travel_book not in", values, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookBetween(String value1, String value2) {
            addCriterion("travel_book between", value1, value2, "travelBook");
            return (Criteria) this;
        }

        public Criteria andTravelBookNotBetween(String value1, String value2) {
            addCriterion("travel_book not between", value1, value2, "travelBook");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeIsNull() {
            addCriterion("document_type is null");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeIsNotNull() {
            addCriterion("document_type is not null");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeEqualTo(Integer value) {
            addCriterion("document_type =", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeNotEqualTo(Integer value) {
            addCriterion("document_type <>", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeGreaterThan(Integer value) {
            addCriterion("document_type >", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("document_type >=", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeLessThan(Integer value) {
            addCriterion("document_type <", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeLessThanOrEqualTo(Integer value) {
            addCriterion("document_type <=", value, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeIn(List<Integer> values) {
            addCriterion("document_type in", values, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeNotIn(List<Integer> values) {
            addCriterion("document_type not in", values, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeBetween(Integer value1, Integer value2) {
            addCriterion("document_type between", value1, value2, "documentType");
            return (Criteria) this;
        }

        public Criteria andDocumentTypeNotBetween(Integer value1, Integer value2) {
            addCriterion("document_type not between", value1, value2, "documentType");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseIsNull() {
            addCriterion("idcard_license is null");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseIsNotNull() {
            addCriterion("idcard_license is not null");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseEqualTo(String value) {
            addCriterion("idcard_license =", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseNotEqualTo(String value) {
            addCriterion("idcard_license <>", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseGreaterThan(String value) {
            addCriterion("idcard_license >", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseGreaterThanOrEqualTo(String value) {
            addCriterion("idcard_license >=", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseLessThan(String value) {
            addCriterion("idcard_license <", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseLessThanOrEqualTo(String value) {
            addCriterion("idcard_license <=", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseLike(String value) {
            addCriterion("idcard_license like", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseNotLike(String value) {
            addCriterion("idcard_license not like", value, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseIn(List<String> values) {
            addCriterion("idcard_license in", values, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseNotIn(List<String> values) {
            addCriterion("idcard_license not in", values, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseBetween(String value1, String value2) {
            addCriterion("idcard_license between", value1, value2, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andIdcardLicenseNotBetween(String value1, String value2) {
            addCriterion("idcard_license not between", value1, value2, "idcardLicense");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportIsNull() {
            addCriterion("vehicle_evaluation_report is null");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportIsNotNull() {
            addCriterion("vehicle_evaluation_report is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportEqualTo(String value) {
            addCriterion("vehicle_evaluation_report =", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportNotEqualTo(String value) {
            addCriterion("vehicle_evaluation_report <>", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportGreaterThan(String value) {
            addCriterion("vehicle_evaluation_report >", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportGreaterThanOrEqualTo(String value) {
            addCriterion("vehicle_evaluation_report >=", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportLessThan(String value) {
            addCriterion("vehicle_evaluation_report <", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportLessThanOrEqualTo(String value) {
            addCriterion("vehicle_evaluation_report <=", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportLike(String value) {
            addCriterion("vehicle_evaluation_report like", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportNotLike(String value) {
            addCriterion("vehicle_evaluation_report not like", value, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportIn(List<String> values) {
            addCriterion("vehicle_evaluation_report in", values, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportNotIn(List<String> values) {
            addCriterion("vehicle_evaluation_report not in", values, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportBetween(String value1, String value2) {
            addCriterion("vehicle_evaluation_report between", value1, value2, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andVehicleEvaluationReportNotBetween(String value1, String value2) {
            addCriterion("vehicle_evaluation_report not between", value1, value2, "vehicleEvaluationReport");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementIsNull() {
            addCriterion("loan_agreement is null");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementIsNotNull() {
            addCriterion("loan_agreement is not null");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementEqualTo(String value) {
            addCriterion("loan_agreement =", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementNotEqualTo(String value) {
            addCriterion("loan_agreement <>", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementGreaterThan(String value) {
            addCriterion("loan_agreement >", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementGreaterThanOrEqualTo(String value) {
            addCriterion("loan_agreement >=", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementLessThan(String value) {
            addCriterion("loan_agreement <", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementLessThanOrEqualTo(String value) {
            addCriterion("loan_agreement <=", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementLike(String value) {
            addCriterion("loan_agreement like", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementNotLike(String value) {
            addCriterion("loan_agreement not like", value, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementIn(List<String> values) {
            addCriterion("loan_agreement in", values, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementNotIn(List<String> values) {
            addCriterion("loan_agreement not in", values, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementBetween(String value1, String value2) {
            addCriterion("loan_agreement between", value1, value2, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andLoanAgreementNotBetween(String value1, String value2) {
            addCriterion("loan_agreement not between", value1, value2, "loanAgreement");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateIsNull() {
            addCriterion("vehicle_certificate is null");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateIsNotNull() {
            addCriterion("vehicle_certificate is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateEqualTo(String value) {
            addCriterion("vehicle_certificate =", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateNotEqualTo(String value) {
            addCriterion("vehicle_certificate <>", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateGreaterThan(String value) {
            addCriterion("vehicle_certificate >", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateGreaterThanOrEqualTo(String value) {
            addCriterion("vehicle_certificate >=", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateLessThan(String value) {
            addCriterion("vehicle_certificate <", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateLessThanOrEqualTo(String value) {
            addCriterion("vehicle_certificate <=", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateLike(String value) {
            addCriterion("vehicle_certificate like", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateNotLike(String value) {
            addCriterion("vehicle_certificate not like", value, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateIn(List<String> values) {
            addCriterion("vehicle_certificate in", values, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateNotIn(List<String> values) {
            addCriterion("vehicle_certificate not in", values, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateBetween(String value1, String value2) {
            addCriterion("vehicle_certificate between", value1, value2, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleCertificateNotBetween(String value1, String value2) {
            addCriterion("vehicle_certificate not between", value1, value2, "vehicleCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateIsNull() {
            addCriterion("vehicle_tax_certificate is null");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateIsNotNull() {
            addCriterion("vehicle_tax_certificate is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateEqualTo(String value) {
            addCriterion("vehicle_tax_certificate =", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateNotEqualTo(String value) {
            addCriterion("vehicle_tax_certificate <>", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateGreaterThan(String value) {
            addCriterion("vehicle_tax_certificate >", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateGreaterThanOrEqualTo(String value) {
            addCriterion("vehicle_tax_certificate >=", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateLessThan(String value) {
            addCriterion("vehicle_tax_certificate <", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateLessThanOrEqualTo(String value) {
            addCriterion("vehicle_tax_certificate <=", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateLike(String value) {
            addCriterion("vehicle_tax_certificate like", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateNotLike(String value) {
            addCriterion("vehicle_tax_certificate not like", value, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateIn(List<String> values) {
            addCriterion("vehicle_tax_certificate in", values, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateNotIn(List<String> values) {
            addCriterion("vehicle_tax_certificate not in", values, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateBetween(String value1, String value2) {
            addCriterion("vehicle_tax_certificate between", value1, value2, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicleTaxCertificateNotBetween(String value1, String value2) {
            addCriterion("vehicle_tax_certificate not between", value1, value2, "vehicleTaxCertificate");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceIsNull() {
            addCriterion("vehical_invoice is null");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceIsNotNull() {
            addCriterion("vehical_invoice is not null");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceEqualTo(String value) {
            addCriterion("vehical_invoice =", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceNotEqualTo(String value) {
            addCriterion("vehical_invoice <>", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceGreaterThan(String value) {
            addCriterion("vehical_invoice >", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceGreaterThanOrEqualTo(String value) {
            addCriterion("vehical_invoice >=", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceLessThan(String value) {
            addCriterion("vehical_invoice <", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceLessThanOrEqualTo(String value) {
            addCriterion("vehical_invoice <=", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceLike(String value) {
            addCriterion("vehical_invoice like", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceNotLike(String value) {
            addCriterion("vehical_invoice not like", value, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceIn(List<String> values) {
            addCriterion("vehical_invoice in", values, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceNotIn(List<String> values) {
            addCriterion("vehical_invoice not in", values, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceBetween(String value1, String value2) {
            addCriterion("vehical_invoice between", value1, value2, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalInvoiceNotBetween(String value1, String value2) {
            addCriterion("vehical_invoice not between", value1, value2, "vehicalInvoice");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoIsNull() {
            addCriterion("vehical_photo is null");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoIsNotNull() {
            addCriterion("vehical_photo is not null");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoEqualTo(String value) {
            addCriterion("vehical_photo =", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoNotEqualTo(String value) {
            addCriterion("vehical_photo <>", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoGreaterThan(String value) {
            addCriterion("vehical_photo >", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoGreaterThanOrEqualTo(String value) {
            addCriterion("vehical_photo >=", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoLessThan(String value) {
            addCriterion("vehical_photo <", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoLessThanOrEqualTo(String value) {
            addCriterion("vehical_photo <=", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoLike(String value) {
            addCriterion("vehical_photo like", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoNotLike(String value) {
            addCriterion("vehical_photo not like", value, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoIn(List<String> values) {
            addCriterion("vehical_photo in", values, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoNotIn(List<String> values) {
            addCriterion("vehical_photo not in", values, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoBetween(String value1, String value2) {
            addCriterion("vehical_photo between", value1, value2, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andVehicalPhotoNotBetween(String value1, String value2) {
            addCriterion("vehical_photo not between", value1, value2, "vehicalPhoto");
            return (Criteria) this;
        }

        public Criteria andLoanContractIsNull() {
            addCriterion("loan_contract is null");
            return (Criteria) this;
        }

        public Criteria andLoanContractIsNotNull() {
            addCriterion("loan_contract is not null");
            return (Criteria) this;
        }

        public Criteria andLoanContractEqualTo(String value) {
            addCriterion("loan_contract =", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractNotEqualTo(String value) {
            addCriterion("loan_contract <>", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractGreaterThan(String value) {
            addCriterion("loan_contract >", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractGreaterThanOrEqualTo(String value) {
            addCriterion("loan_contract >=", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractLessThan(String value) {
            addCriterion("loan_contract <", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractLessThanOrEqualTo(String value) {
            addCriterion("loan_contract <=", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractLike(String value) {
            addCriterion("loan_contract like", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractNotLike(String value) {
            addCriterion("loan_contract not like", value, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractIn(List<String> values) {
            addCriterion("loan_contract in", values, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractNotIn(List<String> values) {
            addCriterion("loan_contract not in", values, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractBetween(String value1, String value2) {
            addCriterion("loan_contract between", value1, value2, "loanContract");
            return (Criteria) this;
        }

        public Criteria andLoanContractNotBetween(String value1, String value2) {
            addCriterion("loan_contract not between", value1, value2, "loanContract");
            return (Criteria) this;
        }

        public Criteria andIouIsNull() {
            addCriterion("iou is null");
            return (Criteria) this;
        }

        public Criteria andIouIsNotNull() {
            addCriterion("iou is not null");
            return (Criteria) this;
        }

        public Criteria andIouEqualTo(String value) {
            addCriterion("iou =", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouNotEqualTo(String value) {
            addCriterion("iou <>", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouGreaterThan(String value) {
            addCriterion("iou >", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouGreaterThanOrEqualTo(String value) {
            addCriterion("iou >=", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouLessThan(String value) {
            addCriterion("iou <", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouLessThanOrEqualTo(String value) {
            addCriterion("iou <=", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouLike(String value) {
            addCriterion("iou like", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouNotLike(String value) {
            addCriterion("iou not like", value, "iou");
            return (Criteria) this;
        }

        public Criteria andIouIn(List<String> values) {
            addCriterion("iou in", values, "iou");
            return (Criteria) this;
        }

        public Criteria andIouNotIn(List<String> values) {
            addCriterion("iou not in", values, "iou");
            return (Criteria) this;
        }

        public Criteria andIouBetween(String value1, String value2) {
            addCriterion("iou between", value1, value2, "iou");
            return (Criteria) this;
        }

        public Criteria andIouNotBetween(String value1, String value2) {
            addCriterion("iou not between", value1, value2, "iou");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementIsNull() {
            addCriterion("capital_requirement is null");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementIsNotNull() {
            addCriterion("capital_requirement is not null");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementEqualTo(String value) {
            addCriterion("capital_requirement =", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementNotEqualTo(String value) {
            addCriterion("capital_requirement <>", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementGreaterThan(String value) {
            addCriterion("capital_requirement >", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementGreaterThanOrEqualTo(String value) {
            addCriterion("capital_requirement >=", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementLessThan(String value) {
            addCriterion("capital_requirement <", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementLessThanOrEqualTo(String value) {
            addCriterion("capital_requirement <=", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementLike(String value) {
            addCriterion("capital_requirement like", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementNotLike(String value) {
            addCriterion("capital_requirement not like", value, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementIn(List<String> values) {
            addCriterion("capital_requirement in", values, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementNotIn(List<String> values) {
            addCriterion("capital_requirement not in", values, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementBetween(String value1, String value2) {
            addCriterion("capital_requirement between", value1, value2, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andCapitalRequirementNotBetween(String value1, String value2) {
            addCriterion("capital_requirement not between", value1, value2, "capitalRequirement");
            return (Criteria) this;
        }

        public Criteria andPolicyIsNull() {
            addCriterion("policy is null");
            return (Criteria) this;
        }

        public Criteria andPolicyIsNotNull() {
            addCriterion("policy is not null");
            return (Criteria) this;
        }

        public Criteria andPolicyEqualTo(String value) {
            addCriterion("policy =", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyNotEqualTo(String value) {
            addCriterion("policy <>", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyGreaterThan(String value) {
            addCriterion("policy >", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyGreaterThanOrEqualTo(String value) {
            addCriterion("policy >=", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyLessThan(String value) {
            addCriterion("policy <", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyLessThanOrEqualTo(String value) {
            addCriterion("policy <=", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyLike(String value) {
            addCriterion("policy like", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyNotLike(String value) {
            addCriterion("policy not like", value, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyIn(List<String> values) {
            addCriterion("policy in", values, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyNotIn(List<String> values) {
            addCriterion("policy not in", values, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyBetween(String value1, String value2) {
            addCriterion("policy between", value1, value2, "policy");
            return (Criteria) this;
        }

        public Criteria andPolicyNotBetween(String value1, String value2) {
            addCriterion("policy not between", value1, value2, "policy");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryIsNull() {
            addCriterion("vehicle_inventory is null");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryIsNotNull() {
            addCriterion("vehicle_inventory is not null");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryEqualTo(String value) {
            addCriterion("vehicle_inventory =", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryNotEqualTo(String value) {
            addCriterion("vehicle_inventory <>", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryGreaterThan(String value) {
            addCriterion("vehicle_inventory >", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryGreaterThanOrEqualTo(String value) {
            addCriterion("vehicle_inventory >=", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryLessThan(String value) {
            addCriterion("vehicle_inventory <", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryLessThanOrEqualTo(String value) {
            addCriterion("vehicle_inventory <=", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryLike(String value) {
            addCriterion("vehicle_inventory like", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryNotLike(String value) {
            addCriterion("vehicle_inventory not like", value, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryIn(List<String> values) {
            addCriterion("vehicle_inventory in", values, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryNotIn(List<String> values) {
            addCriterion("vehicle_inventory not in", values, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryBetween(String value1, String value2) {
            addCriterion("vehicle_inventory between", value1, value2, "vehicleInventory");
            return (Criteria) this;
        }

        public Criteria andVehicleInventoryNotBetween(String value1, String value2) {
            addCriterion("vehicle_inventory not between", value1, value2, "vehicleInventory");
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

        public Criteria andCooperateIdIsNull() {
            addCriterion("cooperate_id is null");
            return (Criteria) this;
        }

        public Criteria andCooperateIdIsNotNull() {
            addCriterion("cooperate_id is not null");
            return (Criteria) this;
        }

        public Criteria andCooperateIdEqualTo(String value) {
            addCriterion("cooperate_id =", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdNotEqualTo(String value) {
            addCriterion("cooperate_id <>", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdGreaterThan(String value) {
            addCriterion("cooperate_id >", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdGreaterThanOrEqualTo(String value) {
            addCriterion("cooperate_id >=", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdLessThan(String value) {
            addCriterion("cooperate_id <", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdLessThanOrEqualTo(String value) {
            addCriterion("cooperate_id <=", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdLike(String value) {
            addCriterion("cooperate_id like", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdNotLike(String value) {
            addCriterion("cooperate_id not like", value, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdIn(List<String> values) {
            addCriterion("cooperate_id in", values, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdNotIn(List<String> values) {
            addCriterion("cooperate_id not in", values, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdBetween(String value1, String value2) {
            addCriterion("cooperate_id between", value1, value2, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andCooperateIdNotBetween(String value1, String value2) {
            addCriterion("cooperate_id not between", value1, value2, "cooperateId");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNull() {
            addCriterion("user_id is null");
            return (Criteria) this;
        }

        public Criteria andUserIdIsNotNull() {
            addCriterion("user_id is not null");
            return (Criteria) this;
        }

        public Criteria andUserIdEqualTo(Integer value) {
            addCriterion("user_id =", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotEqualTo(Integer value) {
            addCriterion("user_id <>", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThan(Integer value) {
            addCriterion("user_id >", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("user_id >=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThan(Integer value) {
            addCriterion("user_id <", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("user_id <=", value, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdIn(List<Integer> values) {
            addCriterion("user_id in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotIn(List<Integer> values) {
            addCriterion("user_id not in", values, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdBetween(Integer value1, Integer value2) {
            addCriterion("user_id between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("user_id not between", value1, value2, "userId");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountIsNull() {
            addCriterion("est_rep_amount is null");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountIsNotNull() {
            addCriterion("est_rep_amount is not null");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountEqualTo(Double value) {
            addCriterion("est_rep_amount =", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountNotEqualTo(Double value) {
            addCriterion("est_rep_amount <>", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountGreaterThan(Double value) {
            addCriterion("est_rep_amount >", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountGreaterThanOrEqualTo(Double value) {
            addCriterion("est_rep_amount >=", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountLessThan(Double value) {
            addCriterion("est_rep_amount <", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountLessThanOrEqualTo(Double value) {
            addCriterion("est_rep_amount <=", value, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountIn(List<Double> values) {
            addCriterion("est_rep_amount in", values, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountNotIn(List<Double> values) {
            addCriterion("est_rep_amount not in", values, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountBetween(Double value1, Double value2) {
            addCriterion("est_rep_amount between", value1, value2, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andEstRepAmountNotBetween(Double value1, Double value2) {
            addCriterion("est_rep_amount not between", value1, value2, "estRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountIsNull() {
            addCriterion("act_rep_amount is null");
            return (Criteria) this;
        }

        public Criteria andActRepAmountIsNotNull() {
            addCriterion("act_rep_amount is not null");
            return (Criteria) this;
        }

        public Criteria andActRepAmountEqualTo(Double value) {
            addCriterion("act_rep_amount =", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountNotEqualTo(Double value) {
            addCriterion("act_rep_amount <>", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountGreaterThan(Double value) {
            addCriterion("act_rep_amount >", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountGreaterThanOrEqualTo(Double value) {
            addCriterion("act_rep_amount >=", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountLessThan(Double value) {
            addCriterion("act_rep_amount <", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountLessThanOrEqualTo(Double value) {
            addCriterion("act_rep_amount <=", value, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountIn(List<Double> values) {
            addCriterion("act_rep_amount in", values, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountNotIn(List<Double> values) {
            addCriterion("act_rep_amount not in", values, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountBetween(Double value1, Double value2) {
            addCriterion("act_rep_amount between", value1, value2, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andActRepAmountNotBetween(Double value1, Double value2) {
            addCriterion("act_rep_amount not between", value1, value2, "actRepAmount");
            return (Criteria) this;
        }

        public Criteria andLoanTimeIsNull() {
            addCriterion("loan_time is null");
            return (Criteria) this;
        }

        public Criteria andLoanTimeIsNotNull() {
            addCriterion("loan_time is not null");
            return (Criteria) this;
        }

        public Criteria andLoanTimeEqualTo(Date value) {
            addCriterion("loan_time =", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeNotEqualTo(Date value) {
            addCriterion("loan_time <>", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeGreaterThan(Date value) {
            addCriterion("loan_time >", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("loan_time >=", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeLessThan(Date value) {
            addCriterion("loan_time <", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeLessThanOrEqualTo(Date value) {
            addCriterion("loan_time <=", value, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeIn(List<Date> values) {
            addCriterion("loan_time in", values, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeNotIn(List<Date> values) {
            addCriterion("loan_time not in", values, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeBetween(Date value1, Date value2) {
            addCriterion("loan_time between", value1, value2, "loanTime");
            return (Criteria) this;
        }

        public Criteria andLoanTimeNotBetween(Date value1, Date value2) {
            addCriterion("loan_time not between", value1, value2, "loanTime");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeIsNull() {
            addCriterion("business_type is null");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeIsNotNull() {
            addCriterion("business_type is not null");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeEqualTo(Integer value) {
            addCriterion("business_type =", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeNotEqualTo(Integer value) {
            addCriterion("business_type <>", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeGreaterThan(Integer value) {
            addCriterion("business_type >", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("business_type >=", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeLessThan(Integer value) {
            addCriterion("business_type <", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeLessThanOrEqualTo(Integer value) {
            addCriterion("business_type <=", value, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeIn(List<Integer> values) {
            addCriterion("business_type in", values, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeNotIn(List<Integer> values) {
            addCriterion("business_type not in", values, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeBetween(Integer value1, Integer value2) {
            addCriterion("business_type between", value1, value2, "businessType");
            return (Criteria) this;
        }

        public Criteria andBusinessTypeNotBetween(Integer value1, Integer value2) {
            addCriterion("business_type not between", value1, value2, "businessType");
            return (Criteria) this;
        }

        public Criteria andProductIdIsNull() {
            addCriterion("product_id is null");
            return (Criteria) this;
        }

        public Criteria andProductIdIsNotNull() {
            addCriterion("product_id is not null");
            return (Criteria) this;
        }

        public Criteria andProductIdEqualTo(Integer value) {
            addCriterion("product_id =", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotEqualTo(Integer value) {
            addCriterion("product_id <>", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdGreaterThan(Integer value) {
            addCriterion("product_id >", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("product_id >=", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdLessThan(Integer value) {
            addCriterion("product_id <", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdLessThanOrEqualTo(Integer value) {
            addCriterion("product_id <=", value, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdIn(List<Integer> values) {
            addCriterion("product_id in", values, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotIn(List<Integer> values) {
            addCriterion("product_id not in", values, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdBetween(Integer value1, Integer value2) {
            addCriterion("product_id between", value1, value2, "productId");
            return (Criteria) this;
        }

        public Criteria andProductIdNotBetween(Integer value1, Integer value2) {
            addCriterion("product_id not between", value1, value2, "productId");
            return (Criteria) this;
        }

        public Criteria andStartTimeIsNull() {
            addCriterion("start_time is null");
            return (Criteria) this;
        }

        public Criteria andStartTimeIsNotNull() {
            addCriterion("start_time is not null");
            return (Criteria) this;
        }

        public Criteria andStartTimeEqualTo(Date value) {
            addCriterion("start_time =", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotEqualTo(Date value) {
            addCriterion("start_time <>", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeGreaterThan(Date value) {
            addCriterion("start_time >", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("start_time >=", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeLessThan(Date value) {
            addCriterion("start_time <", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeLessThanOrEqualTo(Date value) {
            addCriterion("start_time <=", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeIn(List<Date> values) {
            addCriterion("start_time in", values, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotIn(List<Date> values) {
            addCriterion("start_time not in", values, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeBetween(Date value1, Date value2) {
            addCriterion("start_time between", value1, value2, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotBetween(Date value1, Date value2) {
            addCriterion("start_time not between", value1, value2, "startTime");
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