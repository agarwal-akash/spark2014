# generate session files with appropriate unproved Coq files

gnatprove -P spark_lemmas.gpr --prover=cvc4 --level=2 --timeout=auto --no-counterexample -j0

# signed arithmetic
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-arithmetic_lemmas.ads:49
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-arithmetic_lemmas.ads:64

# modular arithmetic
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:48
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:57
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:67
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:77
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:86
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:98
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:106
gnatprove -P spark_lemmas.gpr -U --prover=coq --limit-line=spark-mod_arithmetic_lemmas.ads:114
