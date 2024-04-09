DROP FUNCTION WCISMEDDET.GET_PROF_DIAG_CODE;

CREATE OR REPLACE FUNCTION WCISMEDDET.get_PROF_DIAG_CODE (
p_IDN IN NUMBER)
RETURN WCISMEDARC.PROFDIAGCD IS
p_PROFD WCISMEDARC.PROFDIAGCD;
BEGIN                       

                             select cast(
                                      collect ( WCISMEDARC.PROFDiag_Code 
                                                (TO_NUMBER(SUBSTR(PROF_colnum,(INSTR(PROF_colnum,'CD_',1,2)+3),2),'99'),
                                              ICD9_diag_CD,
                                              ICD10_diag_CD)
                                              ) as WCISMEDARC.PROFDiagCD
                                     ) as DIAG_PROF
                            INTO p_PROFD                     
                            FROM TEMP_PROF_V
                         
                            UNPIVOT          
                            ((ICD9_diag_CD, ICD10_diag_CD)  
                            for PROF_colnum in ((ICD9_diag_CD_1,ICD10_diag_CD_1)
                                                           ,(ICD9_diag_CD_2,ICD10_diag_CD_2)
                                                           ,(ICD9_diag_CD_3,ICD10_diag_CD_3)
                                                           ,(ICD9_diag_CD_4,ICD10_diag_CD_4)
                                                           ,(ICD9_diag_CD_5,ICD10_diag_CD_5)
                                                           ,(ICD9_diag_CD_6,ICD10_diag_CD_6)
                                                           ,(ICD9_diag_CD_7,ICD10_diag_CD_7)
                                                           ,(ICD9_diag_CD_8,ICD10_diag_CD_8)
                                                           ,(ICD9_diag_CD_9,ICD10_diag_CD_9)
                                                           ,(ICD9_diag_CD_10,ICD10_diag_CD_10)
                                                           ,(ICD9_diag_CD_11,ICD10_diag_CD_11)
                                                           ,(ICD9_diag_CD_12,ICD10_diag_CD_12)
                                                           )
                              
                                ) abdd
                            WHERE IDN = p_IDN;                                                                
                               RETURN(p_PROFD);
EXCEPTION
    WHEN others THEN  
                  proc_error_log(p_err_cd => sqlcode
                           ,p_err_txt => 'get_PROF_DIAG failed'
                           ,p_sql_err_msg => sqlerrm);
                       --    CLOSE INSERT_BILLS_cur;
                           RAISE; 
END get_PROF_DIAG_CODE;
/


GRANT EXECUTE ON WCISMEDDET.GET_PROF_DIAG_CODE TO PUBLIC;
