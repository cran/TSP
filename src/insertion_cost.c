#include <R.h>
#include <Rdefines.h>

#include "matrix_pos.h"


/*
 * Calculate insertion cost for the insertion algorithms
 */

SEXP insertion_cost(SEXP R_matrix, SEXP R_order, SEXP R_k) {

    int n = INTEGER(GET_DIM(R_matrix))[0];
    int length = LENGTH(R_order);
    int *order = INTEGER(R_order);
    int k = INTEGER(R_k)[0]-1;
    SEXP R_cost;
    PROTECT(R_cost = NEW_NUMERIC(length));

    double link_add1, link_add2, link_remove;

    if (length == 1) {
        REAL(R_cost)[0] = REAL(R_matrix)[M_POS(n, order[0]-1, k)];
    
    }else{
        for (int i = 0; i < (length-1); i++) {
            
            link_add1 = REAL(R_matrix)[M_POS(n, order[i]-1, k)];
            link_add2 = REAL(R_matrix)[M_POS(n, k, order[i+1]-1)];
            link_remove = REAL(R_matrix)[M_POS(n, order[i]-1, order[i+1]-1)];

            //Rprintf("Links: %f %f %f\n", link_add1, link_add2, link_remove);
        
            // check for infinity
            if(link_add1 == R_NegInf 
                    || link_add2 == R_NegInf
                    || link_remove == R_PosInf) 
                REAL(R_cost)[i] = R_NegInf;
            
            else if(link_add1 == R_PosInf 
                    || link_add2 == R_PosInf 
                    || link_remove == R_NegInf) 
                REAL(R_cost)[i] = R_PosInf;
            
            else    
                REAL(R_cost)[i] = link_add1 + link_add2 - link_remove;
        }

        link_add1 = REAL(R_matrix)[M_POS(n, order[length-1]-1, k)];
        link_add2 = REAL(R_matrix)[M_POS(n, k, order[0]-1)]; 
        link_remove = REAL(R_matrix)[M_POS(n, order[length-1]-1, order[0]-1)]; 
            
        // check for infinity
        if(link_add1 == R_PosInf || link_add2 == R_PosInf) 
            REAL(R_cost)[length-1] = R_PosInf;
        else if(link_remove == R_PosInf) 
            REAL(R_cost)[length-1] = R_NegInf;   // removing a inf is very good
        else
            REAL(R_cost)[length-1] = link_add1 + link_add2 - link_remove;
    }

    UNPROTECT(1);
    return R_cost;
}

