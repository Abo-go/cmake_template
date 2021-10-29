#include "dataAnalysis.h"
#include <algorithm>
#include <sstream>
#include "csv_parser/include/csv.hpp"

void StatResults::calFromData(const std::vector<double>& data)
{
    if (data.size() == 0)
    {
        return;
    }

    // Cal MIN MAX MEAN    
    auto dataCpy = data;
    std::sort(dataCpy.begin(), dataCpy.end());

    MIN = dataCpy.front();
    MAX = dataCpy.back();
    MEAN = dataCpy[data.size() / 2];

    // Cal RMS SUM AVG
    RMS = 0;
    SUM = 0;
    for (int i = 0; i < data.size(); i++)
    {

        SUM += data[i];
        RMS += data[i] * data[i];
    }

    AVG = SUM / data.size();
    RMS = sqrt(RMS / data.size());
    Confi95 = dataCpy[data.size() * 0.95];

    // Cal STDDEV
    STDDEV = 0;
    for (int i = 0; i < data.size(); i++)
    {
        STDDEV += (data[i] - AVG) * (data[i] - AVG);
    }

    STDDEV = sqrt(STDDEV / data.size());
    MAXDEV = MAX - AVG;
    MINDEV = AVG - MIN;
}

DataColumn::DataColumn(std::string name /*= ""*/) :
    mName(name)
{

}

std::string DataColumn::getName() const
{
    return mName;
}

double DataColumn::getData(int idx) const
{
    return mData[idx];
}

size_t DataColumn::getSize() const
{
    return mData.size();
}

void DataColumn::statCal()
{
    auto data = mData;
    for (int i = 0; i < data.size(); i++)
    {
        data[i] = abs(data[i]);
    }

    mStatResults.calFromData(data);
}

std::string DataColumn::prettyPrintDEV() const
{
    std::ostringstream os;
    os << mName
#if 0
        << ", MAX:" << mStatResults.MAX
        << ", MIN:" << mStatResults.MIN
        << ", MEAN:" << mStatResults.MEAN
        << ", AVG:" << mStatResults.AVG
        << ", RMS:" << mStatResults.RMS
        << ", STDDEV:" << mStatResults.STDDEV;
#else
        << ", MAXDEV:" << mStatResults.MAXDEV
        << ", MINDEV:" << mStatResults.MINDEV
        << ", STDDEV:" << mStatResults.STDDEV;
#endif

    return os.str();
}

std::map<std::string, double> DataColumn::getColumnDEVResult() const
{
    std::map<std::string, double> dataMap;

    dataMap[mName + "-AVG"] = mStatResults.AVG;
    dataMap[mName + "-RMS"] = mStatResults.RMS;
    dataMap[mName + "-Confi95"] = mStatResults.Confi95;
    dataMap[mName + "-STDDEV"] = mStatResults.STDDEV;

    return dataMap;
}

std::string DataColumn::prettyPrintNOR() const
{
    std::ostringstream os;
    os << mName
        << ", AVG:" << mStatResults.AVG
        << ", RMS:" << mStatResults.RMS
        << ", Confi95:" << mStatResults.Confi95
        << ", STDDEV:" << mStatResults.STDDEV;

    return os.str();
}

std::map<std::string, double> DataColumn::getColumnNORResult() const
{
    std::map<std::string, double> dataMap;
    return dataMap;
}

void DataColumn::pushBackData(double data)
{
    mData.push_back(data);
}

DataAnalysis::DataAnalysis()
{

}

std::string DataAnalysis::getComment(int frame)
{
    if (frame >= mComments.size())
    {
        return "";
    }
    else
    {
        return mComments[frame];
    }
}

void DataAnalysis::init(const std::vector<std::string>& columnNames)
{
    mColumns.clear();
    for (auto name : columnNames)
    {
        mColumns.push_back(std::make_shared<DataColumn>(name));
    }

    mFrameNum = 0;
}

void DataAnalysis::initData(const std::vector<std::vector<double>>& allColumnData)
{
    for (int i = 0; i < mColumns.size(); i++)
    {
        mColumns[i]->mData = allColumnData[i];
    }
}

bool DataAnalysis::pushBackData(const std::vector<double>& columnData, std::string comment)
{
    if (mColumns.size() != columnData.size())
    {
        printf("Analysis Data Size Error!\n");
        return false;
    }

    for (int i = 0; i < columnData.size(); i++)
    {
        mColumns[i]->pushBackData(columnData[i]);
    }

    mComments.push_back(comment);
    mFrameNum++;

    return true;
}

void DataAnalysis::analyse()
{
    for (auto icolumn : mColumns)
    {
        icolumn->statCal();
    }
}

void DataAnalysis::clear()
{
    mColumns.clear();
    mComments.clear();
    mFrameNum = 0;
}

int DataAnalysis::getFrameNum() const
{
    return mFrameNum;
}

void DataAnalysis::saveCSV(std::string path)
{
    std::ofstream fs;
    fs.open(path, std::ios::out);
    auto writer = csv::make_csv_writer(fs);
    std::vector<std::string> headers;   
    for (auto icolumn : mColumns)
    {
        headers.push_back(icolumn->mName);
    }
    headers.push_back("COMMENT");

    writer << headers;
    std::vector<std::string> data;
    for (int i = 0; i < mFrameNum; i++)
    {
        data.clear();
        for (auto icolumn : mColumns)
        {
            data.push_back(std::to_string(icolumn->mData[i]));
        }
        if (i < mComments.size())
        {
            data.push_back(mComments[i]);
        }
        writer << data;
    }

    fs.close();
}

void DataAnalysis::loadCSV(std::string path)
{
    //¶ÁÈ¡csvÊý¾Ý
    csv::CSVReader reader(path);

    std::vector<std::string> titles;
    std::vector<std::vector<double>> data;
    std::vector<double> coloumDatas;

    int idx = 0;
    int commentCol = -1;
    for (auto& row : reader)
    {

        if (idx == 0)
        {
            int jdx = 0;
            auto names = row.get_col_names();
            for (auto& field : names)
            {
                if (field == "COMMENT")
                {
                    commentCol = jdx;
                }
                else
                {
                    titles.push_back(field);
                }
                jdx++;
            }

            init(titles);
        }

        int jdx = 0;
        for (auto& field : row)
        {
            if (jdx != commentCol)
            {
                coloumDatas.push_back(field.get<double>());
            }
            else
            {
                mComments.push_back(field.get_sv().data());
            }
            jdx++;
        }

        pushBackData(coloumDatas);
        coloumDatas.clear();

        idx++;
    }

}

