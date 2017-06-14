#include "mex.h" 
//author: 汪帮主 2010.05.05
//MATLAB调用形式： [resizedArr, resizedDims] = ResizeArray(arr, selRows, sekCols)
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	if (nrhs != 3)
	{
		mexErrMsgTxt("参数个数不正确!");
	}

	int rowNum = mxGetM(prhs[0]);
	int colNum = mxGetN(prhs[0]);
	double* pArr = (double*)mxGetPr(prhs[0]);
	//得到选择的行列信息
	//无论是行向量还是列向量均支持
	double* pSelRows = (double*)mxGetPr(prhs[1]);
	double* pSelCols = (double*)mxGetPr(prhs[2]);
	int selRowsRowNum = mxGetM(prhs[1]);
	int selRowsColNum = mxGetN(prhs[1]);
	if (selRowsRowNum != 1 && selRowsColNum != 1)
	{
		mexErrMsgTxt("行参数不正确！");
	}
	int selRowsNum = selRowsRowNum*selRowsColNum;


	int selColsRowNum = mxGetM(prhs[2]);
	int selColsColNum = mxGetN(prhs[2]);
	if (selColsRowNum != 1 && selColsColNum != 1)
	{
		mexErrMsgTxt("列参数不正确！");
	}
	int selColsNum = selColsRowNum*selColsColNum;

	plhs[1] = mxCreateDoubleMatrix(2, 1, mxREAL);
	double* resizedDims = (double*)mxGetPr(plhs[1]);
	resizedDims[0] = selRowsNum;
	resizedDims[1] = selColsNum;

	plhs[0] = mxCreateDoubleMatrix(selRowsNum, selColsNum, mxREAL);
	double* pResizedArr = (double*)mxGetPr(plhs[0]);

	//这里因为MATLAB中数据得按列优先
#define ARR(row,col) pArr[(col)*rowNum+row]
#define RARR(row,col) pResizedArr[(col)*selRowsNum+row]
	for (int ri = 0; ri<selRowsNum; ri++)
	{
		for (int ci = 0; ci<selColsNum; ci++)
		{
			RARR(ri, ci) = ARR((int)pSelRows[ri] - 1, (int)pSelCols[ci] - 1);
		}
	}

	mexPrintf("OK!\n");
}