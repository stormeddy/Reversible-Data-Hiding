/*You can include any C libraries that you normally use*/
#include "mex.h"  
#include <math.h>
#include <stdio.h>

/* #define DEBUG_GETMASK */

int compare_M (const void * a, const void * b)
{return ( ((double*)a)[1] > ((double *)b)[1] );}

int compare_N (const void * a, const void * b)
{return ( ((double*)a)[0] > ((double *)b)[0] );}

int compare_Nrev (const void * a, const void * b)
{return ( ((double*)a)[0] < ((double *)b)[0] );}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double t_coords[8];
    double w[4],b[4],res[4];
    int dims[2];

    if (nlhs != 1)
        mexErrMsgTxt("one output argument required");
    if (nrhs != 2)
        mexErrMsgTxt("Two input arguments required");

    const char *Image = (char *)mxGetPr(prhs[0]);
    unsigned int N = (unsigned int)(mxGetN(prhs[0])/3);
    unsigned int M = mxGetM(prhs[0]);
    #ifdef DEBUG_GETMASK
    printf("mxGetM(prhs[0]) = %d, mxGetN(prhs[0]) = %d\n", M,N);
    #endif
    double *coords = (double *)mxGetPr(prhs[1]);
    #ifdef DEBUG_GETMASK
    printf("mxGetM(prhs[1]) = %d, mxGetN(prhs[1]) = %d\n", mxGetM(prhs[1]),mxGetN(prhs[1]));
    #endif
    dims[0] = (int)M;
    dims[1] = (int)N;
    
    plhs[0] = mxCreateNumericArray(2, dims, mxUINT8_CLASS, mxREAL);
    char *mask = (char *)mxGetPr(plhs[0]);
    
    if (!mask) mexErrMsgTxt("Failed to create ouput argument");
    
    for (unsigned int i=0;i<4;i++)
    {
        t_coords[2*i] = coords[i];
        t_coords[2*i+1] = coords[4+i];
    }
    qsort(t_coords,4,2*sizeof(double),compare_M);
    qsort(t_coords,2,2*sizeof(double),compare_N);
    qsort(t_coords+4,2,2*sizeof(double),compare_Nrev);
    
    for (unsigned int i=0;i<4;i++)
    {
        coords[i] = t_coords[2*i];
        coords[4+i] = t_coords[2*i+1];
    }
    
	bool w1gt = true;
	bool w3gt = true;
    for (unsigned int i=0 ; i<4; i++)
    {
        unsigned int dim2 = (i==3)?0:i+1;
        
        w[i] = (coords[4+dim2] - coords[4+i]) / ( coords[dim2] - coords[i]);
        b[i] = coords[4+dim2] - coords[dim2]*w[i];
        
		w1gt = (w[1]>0)?true:false;
		w3gt = (w[3]>0)?true:false;
        //if (w[1]>0) w1gt = true;
        //else w1gt = false;
        //if (w[3]>0) w3gt = true;
        //else w3gt = false;
        #ifdef DEBUG_GETMASK
        printf("w = %g, b = %g, coords[i] = %g, coords[dim2] = %g, coords[dim2+4]=%g\n",w[i],b[i],coords[i],coords[dim2],coords[dim2+4]);
        #endif
    }
    
/*    minN = (int)(floor((coords[0]>coords[3])?coords[3]:coords[0]));
    maxN = (int)(ceil((coords[1]>coords[2])?coords[1]:coords[2]));
 
    minM = (int)(floor((coords[4]>coords[5])?coords[5]:coords[4]));
    maxM = (int)(ceil((coords[6]>coords[7])?coords[6]:coords[7]));*/
    
    int minN = (int)(floor((coords[0]>coords[1])?coords[1]:coords[0]));
    minN = (int)(floor((minN>coords[2])?coords[2]:minN));
    minN = (int)(floor((minN>coords[3])?coords[3]:minN));
    int maxN = (int)(ceil((coords[0]>coords[1])?coords[0]:coords[1]));
    maxN = (int)(ceil((coords[2]>maxN)?coords[2]:maxN));
    maxN = (int)(ceil((coords[3]>maxN)?coords[3]:maxN));
    
    int minM = (int)(floor((coords[4]>coords[5])?coords[5]:coords[4]));
    minM = (int)(floor((minM>coords[6])?coords[6]:minM));
    minM = (int)(floor((minM>coords[7])?coords[7]:minM));
    int maxM = (int)(ceil((coords[4]>coords[5])?coords[4]:coords[5]));
    maxM = (int)(ceil((coords[6]>maxM)?coords[6]:maxM));
    maxM = (int)(ceil((coords[7]>maxM)?coords[7]:maxM));
    
    minN=(minN<0)?0:minN;
    minM=(minM<0)?0:minM;
    
    maxN=(maxN>=N)?N:maxN;
    maxM=(maxM>=M)?M:maxM;
    
    #ifdef DEBUG_GETMASK
    printf("minN = %d, maxN = %d\n",minN,maxN);
    printf("minM = %d, maxM = %d\n",minM,maxM);
    #endif
    
    for (unsigned int n=minN; n<maxN; n++)
    {
        res[0] = w[0]*n+b[0];
        if (res[0] > M) continue;
        res[1] = w[1]*n+b[1];
        if (res[1] > M && w1gt) continue;
        if (res[1] <0 && !w1gt) continue;
        res[2] = w[2]*n+b[2];
        if (res[2] < 0) continue;
        res[3] = w[3]*n+b[3];
        if (res[3] < 0 && w3gt) continue;
        if (res[3] > M && !w3gt) continue;
        
        unsigned int nM = n*M;
        
        for (unsigned int m=minM; m<maxM ; m++)
        {
            if (res[0] > m) continue;
            if (res[2] < m) continue;
            if (w1gt && res[1] > m) continue;
            else if (!w1gt && res[1] < m) continue;
            if (w3gt && res[3] < m) continue;
            else if (!w3gt && res[3] > m) continue;
            
            mask[nM+m] = 1;
        }
        
    }
    
    return;
}

