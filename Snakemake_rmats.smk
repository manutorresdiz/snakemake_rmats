# Manu's code is double commented out
configfile: "config/Snakemake_rmats_config.yaml" ## "./metadata/config.yaml"

import pandas as pd
import os

units_table = pd.read_csv(config["samples"])
samples= list(units_table.sample_name.unique())
#units= list(units_table.Unit)
#print(units)
bam_path= config["bam_path"]

rule all:
	input:
		expand("results/rmats/{sample_name}/summary.txt",sample_name=samples)


rule link_files:
	params:
		lambda wildcards:expand("results/mapped/{{unit}}_Aligned.sortedByCoord.out{ext}",ext=[".bam",".bam.bai"],unit=units_table.Sample_Name)
	output:
		multiext("data/bam_files/{unit}_Aligned.sortedByCoord.out",".bam",".bam.bai")
	resources:
		cpu=1,
		mem="1G",
		time="5:00"
	message:
		"soft linking {wildcards.unit} sample"
	shell:
		"""
		ln -s results/mapped/{wildcards.unit}_Aligned.sortedByCoord.out.bam results/rmats/data/bam_files/{wildcards.unit}_Aligned.sortedByCoord.out.bam
		ln -s results/mapped/{wildcards.unit}_Aligned.sortedByCoord.out.bam.bai results/rmats/data/bam_files/{wildcards.unit}_Aligned.sortedByCoord.out.bam.bai
		"""


rule files_prep:
	input:
		file=config["comparison"]
	params:
		path=config["project_path"]
	output:
		expand("metadata/{sample_name}.txt",sample_name=samples)
	resources:
		cpu=1,
		mem="1G",
		time="1:00:00"
	message:
		"creating config_files"
	shell:
		"scripts/script_samples_rule.sh {params.path} {input.file}"


#rule rmats:
#	input:
#		expand("metadata/{{sample_name}}_{type}.txt",type=["Primary","Relapse"],sample_name=samples),
#		lambda wildcards:expand("data/bam_files/{unit}.bam",unit=units_table.Unit[units_table.sample_name == wildcards.sample_name]),
#		gtf=config["gtf_anno"]
#	params:
#		path=config["project_path"],
#		tmp_path="results/tmp/{sample_name}/",
#		final_path="results/rmats/{sample_name}/",
#		P1="metadata/{sample_name}_Primary.txt",
#		P2="metadata/{sample_name}_Relapse.txt"
#	resources:
#		cpu=4,
#		time="96:00:00",
#		mem=lambda wildcards, attempt: attempt * 25
#	output:
#		final="results/rmats/{sample_name}/summary.txt",
#		tmp="results/tmp/{sample_name}/README.txt"
##	message:
##		"Runing rmats on {wildcards.sample_name} samples"
#	shell:
#		"""
#		echo "just to create folder" > {output.tmp}
#		/home/torresdizm/Downloads/rmats_turbo_v4_1_1/run_rmats \
#		--paired-stats --b1 {params.path}{params.P1} --b2 {params.path}{params.P2} \
#		--novelSS --gtf {input.gtf} -t paired --readLength 75 \
#		--nthread {resources.cpu} --tmp {params.path}{params.tmp_path} \
#		--od {params.path}{params.final_path}
#		"""
