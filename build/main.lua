---@class Darwin
darwin = darwin


function main()
    local possible_test = darwin.argv.get_next_unused()

    if possible_test == "test_container" then
        local container_name = darwin.argv.get_next_unused()
        if container_name == nil then
            print("Please provide a container name")
            return
        end
        os.execute("mkdir -p release")
        local image = darwin.ship.create_machine(container_name .. ":latest")
        image.provider = CONTANIZER

        image.start({
            flags = { "-it" },
            volumes = {
                { "./release", "/release" },
            },
        })

        return
    end

    
    Install_dependencies()
    if true then return end
    local assets_recrreated  = create_assets()    
    silver_chain_organize()
    if assets_recrreated then
        local new_assets_sha = darwin.dtw.generate_sha_from_file("src/assets/globals.assets.c")
        print("new assets sha: ", new_assets_sha)
    end 

    local build_funcs = create_build_funcs()


    darwin.dtw.remove_any("release")
    darwin.dtw.remove_any(".cache")
    local i = 1
    for name, buld_lambda in pairs(build_funcs) do
        if darwin.argv.one_of_args_exist(name) then
            print("\n=========================================================================================")
            print("\tstarted of build:", i, "\n")
            buld_lambda()
            print("\n\tA build [" .. i .. "] finished")
            print("=========================================================================================\n\n")
            i = i + 1
        end
    end

    darwin.dtw.move_any_overwriting("release/alpine_static_bin.out","release/"..PROJECT_NAME..".out")
    darwin.dtw.move_any_overwriting("release/windows64.exe","release/"..PROJECT_NAME.."64.exe")
    darwin.dtw.move_any_overwriting("release/windowsi32.exe","release/"..PROJECT_NAME.."i32.exe")
    darwin.dtw.move_any_overwriting("release/debian_static.deb","release/"..PROJECT_NAME..".deb")
    darwin.dtw.move_any_overwriting("release/rpm_static_build.rpm","release/"..PROJECT_NAME..".rpm")

end
