#pragma once
#include "lib_a_api.h"

struct LIB_A_API StatResults
{
    double SUM;         //��
    double MAX;         //���ֵ
    double MIN;         //��Сֵ
    double MEAN;        //��λ��
};

class LIB_A_API DataAnalysis
{
public:
    DataAnalysis();
    StatResults result;
};