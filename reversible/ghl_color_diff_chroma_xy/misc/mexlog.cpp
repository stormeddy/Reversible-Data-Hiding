#include <math.h>
#include "mex.h"

unsigned int numnonzeros(const mxArray*);


void mexlog(const double*y, double*yp, int m) 
{
	for (unsigned int k=0; k<m; ++k)
		yp[k] = log(y[k]);
}


void mexFunction( const int nlhs, mxArray *plhs[], 
                  const int nrhs, const mxArray *prhs[] )
{ 
    /* Check for proper number of arguments */    
    if (nrhs != 1) 
        mexErrMsgTxt("mexlog: only one input argument required."); 
    else if (nlhs > 1)
        mexErrMsgTxt("mexlog: too many output arguments."); 
    

    unsigned int m = mxGetM(prhs[0]);
    unsigned int n = mxGetN(prhs[0]);
    
    plhs[0] = mxCreateDoubleMatrix(m,n,(mxComplexity)mxIsComplex(prhs[0]));
    
    /* Assign pointers to the various parameters */ 
    double *yp = mxGetPr(plhs[0]);    
	if (!yp) mexErrMsgTxt("Could not create output matrix");
    const double *y = mxGetPr(prhs[0]);

    if (!(mxIsSparse(prhs[0])))
		mexlog(y,yp,n*m);
    else{ /* sparse input matrix */
		unsigned int indx = 0;
		int *jc_in = mxGetJc(prhs[0]);
		int *ir_in = mxGetIr(prhs[0]);

		for (unsigned int indc=0;indc<n;indc++)
		{
			unsigned int next_indx = jc_in[indc+1];
			unsigned int mindc = m*indc;
			while (indx<next_indx)
			{
				unsigned int next_ir = ir_in[indx];
				for (unsigned int cnt=0;cnt<m;cnt++)
				{
					if (cnt==next_ir)
					{
						mexlog(y+indx,yp+mindc+cnt,1);
						indx++;
						next_ir = ir_in[indx];
					}
					else /* zero at that point: exp(0) = 1 */
						yp[mindc+cnt] = 1;
				}
			}
		}
    }
	
    /* do it for the complex part as well */
    if (mxIsComplex(prhs[0]))
	{
		double *ypi = mxGetPi(plhs[0]);
		double *yi = mxGetPi(prhs[0]);	
		if (!(mxIsSparse(prhs[0])))
			mexlog(yi,ypi,m*n); 
		else
		{ /* sparse input matrix */
			unsigned int indx = 0;
			int *jc_in = mxGetJc(prhs[0]);
			int *ir_in = mxGetIr(prhs[0]);
	    
			for (unsigned int indc=0;indc<n;indc++)
			{
				unsigned int mindc = indc*m;
				unsigned int next_indx = jc_in[indc+1];
				while (indx<next_indx)
				{
					unsigned int next_ir = ir_in[indx];
					for (unsigned int cnt=0;cnt<m;cnt++)
					{
						if (cnt==next_ir)
						{
							mexlog(yi+indx,ypi+mindc+cnt,1);
							indx++;
							next_ir = ir_in[indx];
						}
						else /* zero at that point: exp(0) = 1 */
							ypi[mindc+cnt] = 1;
					}
				}
			}
		}
	}
	return;
}


/* count number of nonzero entries */
unsigned int numnonzeros(const mxArray *prhs)
{
	unsigned int nnz = 0;
	
	if (mxIsSparse(prhs))
		nnz = *(mxGetJc(prhs)+mxGetN(prhs));
	else if (mxIsDouble(prhs)){
		unsigned int n=mxGetNumberOfElements(prhs);
		const double *xr=mxGetPr(prhs);
		const double *xi=mxGetPi(prhs);
		if (xi!=NULL)
			for (unsigned int i=0;i<n;i++)
			{
				if (xr[i]!=0) nnz++;
				else if (xi[i]!=0) nnz++;
			}
		else
			for (unsigned int i=0;i<n;i++) if (xr[i]!=0) nnz++;
	}
	else
		mexErrMsgTxt("Function not defined for variables of input class");
	
	return(nnz);
}
