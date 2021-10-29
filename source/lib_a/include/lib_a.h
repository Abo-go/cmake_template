#pragma once
#include "lib_a_api.h"

struct LIB_A_API StatResults
{
    double SUM;         //和
    double MAX;         //最大值
    double MIN;         //最小值
    double MEAN;        //中位数
};

class LIB_A_API DataAnalysis
{
public:
    DataAnalysis();
    StatResults result;
};