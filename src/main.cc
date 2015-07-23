


#include <stdlib.h>
#include <stdio.h>
#include <libelf.h>
#include <fcntl.h>


/*---------------------------------------------------------------------------*/
//
//
void print_symbols(Elf *elf, Elf_Scn *scn, Elf32_Shdr *shdr)
{
	Elf_Data 	*data;
	char 		*name;
	data 		= 0;
	int number 	= 0;
	
	if ((data = elf_getdata(scn, data)) == 0 || data->d_size == 0)
	{
		/* error or no data */
		fprintf(stderr, "Section had no data!\n");
		exit(-1);
	}
	
	/*now print the symbols*/
	Elf32_Sym *esym 	= (Elf32_Sym *)data->d_buf;
	Elf32_Sym *lastsym 	= (Elf32_Sym *)((char*)data->d_buf 
											+ data->d_size);
	
	/* now loop through the symbol table and print it*/
	for (; esym < lastsym; esym++)
	{
	/*
		if ((esym->st_value == 0) ||
			  (ELF32_ST_BIND(esym->st_info)== STB_WEAK) ||
			  (ELF32_ST_BIND(esym->st_info)== STB_NUM) ||
			  (ELF32_ST_TYPE(esym->st_info)!= STT_FUNC)) 
				  continue;
	*/
		if (ELF32_ST_TYPE(esym->st_info) == STT_OBJECT)
		{
		 	name = elf_strptr(elf, shdr->sh_link, (size_t)esym->st_name);
		 	if (!name) {
			  	fprintf(stderr,"%sn", elf_errmsg(elf_errno()));
			  	exit(-1);
		 	}
		 	printf("\t%d: 0x%08x %d %sn\n", number++, esym->st_value
		 							   , esym->st_size, name);
		}
	 }

}

/*---------------------------------------------------------------------------*/
//
//
void print_section(Elf *elf)
{
	size_t i = 0;
	size_t  section_nr = 0;
	Elf_Scn *section = NULL;

	elf_getshdrnum(elf, &section_nr);
	printf("\n\nprint_section\n");
	printf("	-> section number[%ld]\n", section_nr);


	for (i = 0; i < section_nr; i++)
	{
		Elf32_Shdr 	*shdr = NULL;
		
		section = elf_getscn(elf, i);
		if (NULL == section) 
		{
			printf("get sec[%ld] error %s\n", i
								, elf_errmsg(elf_errno()));
			break;
		}

		shdr = elf32_getshdr(section);
		if (NULL != shdr)
		{
			printf("section type %d\n", shdr->sh_type);
			if (SHT_SYMTAB == shdr->sh_type)
			{
				print_symbols(elf, section, shdr);
			}
		}
		
	}




	return;
}


/*---------------------------------------------------------------------------*/
//
//
int main(int argc, char *argv[])
{
	int		fd		= 0;
	Elf		*elf	= NULL;
	Elf32_Ehdr		*elf32_hdr = NULL;

	if (EV_NONE == elf_version(EV_CURRENT))
	{
		printf("libelf is out of date.\n");
		return -1;
	}

	if (argc != 2)
	{
		printf("input param error.\n");
		return -1;
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0)
	{
		printf("open file failed.\n");
		return -1;
	}

	elf = elf_begin(fd, ELF_C_READ, NULL);
	elf32_hdr = elf32_getehdr(elf);
	if (NULL == elf32_hdr)
	{
		printf("elf32_getehdr failed\n");
		return -1;
	}
	print_section(elf);

	return 0;
}


