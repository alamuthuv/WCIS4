DROP FUNCTION WCISMEDDET.GET_INST_DIAG_CODE;

CREATE OR REPLACE FUNCTION WCISMEDDET.get_INST_DIAG_CODE (
p_IDN IN NUMBER)
RETURN WCISMEDARC.INSTDIAGCD IS
p_INSTD WCISMEDARC.INSTDIAGCD;

BEGIN                            
                                
                           select cast(
                                      collect ( WCISMEDARC.INSTDiag_Code 
                                              (TO_NUMBER(SUBSTR(diag_colnum,(INSTR(diag_colnum,'_',1,11)+1),2),'99'),
                                              present_admit_ind,
                                              icd9_diag_cd,
                                              icd10_diag_cd)
                                              ) as WCISMEDARC.INSTDiagCD
                                     ) as DIAG_I1
                            INTO p_INSTD                            
                            FROM                         
                            TEMP_INST_V
                            UNPIVOT              --consolidate icd10 diagnosis and present admit indicator columns
                            ((icd9_diag_cd,icd10_diag_cd,present_admit_ind)  
                            for diag_colnum in ((icd9_diag_cd_1,icd10_diag_cd_1,present_admit_ind_1)
                                                           ,(icd9_diag_cd_2,icd10_diag_cd_2,present_admit_ind_2)
                                                           ,(icd9_diag_cd_3,icd10_diag_cd_3,present_admit_ind_3)
                                                           ,(icd9_diag_cd_4,icd10_diag_cd_4,present_admit_ind_4)
                                                           ,(icd9_diag_cd_5,icd10_diag_cd_5,present_admit_ind_5)
                                                           ,(icd9_diag_cd_6,icd10_diag_cd_6,present_admit_ind_6)
                                                           ,(icd9_diag_cd_7,icd10_diag_cd_7,present_admit_ind_7)
                                                           ,(icd9_diag_cd_8,icd10_diag_cd_8,present_admit_ind_8)
                                                           ,(icd9_diag_cd_9,icd10_diag_cd_9,present_admit_ind_9)
                                                           ,(icd9_diag_cd_10,icd10_diag_cd_10,present_admit_ind_10)
                                                           ,(icd9_diag_cd_11,icd10_diag_cd_11,present_admit_ind_11)
                                                           ,(icd9_diag_cd_12,icd10_diag_cd_12,present_admit_ind_12)
                                                           )
                              
                                ) abd
                            WHERE IDN = p_IDN;                                
                               RETURN(p_INSTD);                             

EXCEPTION
    WHEN others THEN  
                  proc_error_log(p_err_cd => sqlcode
                           ,p_err_txt => 'get_INST_DIAG failed'
                           ,p_sql_err_msg => sqlerrm);
                        --   CLOSE INSERT_BILLS_cur;
                           RAISE; 
END get_INST_DIAG_CODE;
/


GRANT EXECUTE ON WCISMEDDET.GET_INST_DIAG_CODE TO PUBLIC;
