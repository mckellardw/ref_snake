# install programs into the conda environment

rule check_and_install_programs:
    run:
        import subprocess
        import yaml
        for program, executable_path in EXEC.items():
            try:
                # Try to run the program
                subprocess.check_call([executable_path, '--version'])
            except (subprocess.CalledProcessError, FileNotFoundError):
                # If it fails, install the program with conda
                print(f'Installing {program}...')
                subprocess.check_call(['conda', 'install', '-c', 'bioconda', program, '-y'])
                
                # Update the EXEC dictionary with the new executable path
                new_executable_path = subprocess.check_output(['which', program]).decode().strip()
                EXEC[program] = new_executable_path

        # Write the updated EXEC dictionary back to the yaml file
        with open('exec.yml', 'w') as file:
            yaml.dump(EXEC, file)
