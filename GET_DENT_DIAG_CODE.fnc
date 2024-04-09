DROP FUNCTION WCISMEDDET.GET_DENT_DIAG_CODE;

CREATE OR REPLACE FUNCTION WCISMEDDET.get_DENT_DIAG_CODE (
p_IDN IN NUMBER)
RETURN WCISMEDARC.DENTDIAGCD IS
p_DENTD WCISMEDARC.DENTDIAGCD;
BEGIN                       

                             select cast(
                                      collect ( WCISMEDARC.DENTDiag_Code 
                                                (TO_NUMBER(SUBSTR(dent_colnum,(INSTR(dent_colnum,'CD_',1,2)+3),2),'99'),
                                              ICD9_diag_CD,
                                              ICD10_diag_CD)
                                              ) as WCISMEDARC.DENTDiagCD
                                     ) as DIAG_DENT
                            INTO p_DENTD                        
                            FROM TEMP_DENT_V                        
                            UNPIVOT          
                            ((ICD9_diag_CD, ICD10_diag_CD)  
                            for dent_colnum in ((ICD9_diag_CD_1,ICD10_diag_CD_1)
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
                               RETURN(p_DENTD);
EXCEPTION
    WHEN others THEN  
                  proc_error_log(p_err_cd => sqlcode
                           ,p_err_txt => 'get_DENT_DIAG failed'
                           ,p_sql_err_msg => sqlerrm);
                        --   CLOSE INSERT_BILLS_cur;
                           RAISE; 
END get_DENT_DIAG_CODE;
/


GRANT EXECUTE ON WCISMEDDET.GET_DENT_DIAG_CODE TO PUBLIC;
