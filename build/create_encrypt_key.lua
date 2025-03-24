
function create_encrypt_key(encrypt_key)

    props ={
        key =encrypt_key,
        name = PROJECT_NAME,
        seed = 232954,
        debug = false,
        fake_byte_set = 0, 
        create_a_integer = 0.33,
         max_operations_per_line = 6, 
        min_operations_per_line = 3, 
        create_a_for =0.33,
        create_a_if = 0.33,
        max_scopes = 4,  
        close_scopes = 0.66, 
        integer_set = 0, 
        fake_byte_set = 0.33,
        real_byte_set = 0.5 
    }
    code = key_obfuscate.create_procedural_generation (props)
    darwin.dtw.write_file("src/macros.encrypt_key.h", code)

end 