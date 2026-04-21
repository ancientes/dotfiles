function reload --description 'Reload all fish files into the current shell'
    source ~/.config/fish/config.fish

    for file in $__fish_config_dir/functions/*.fish
        source $file
    end

    for file in $__fish_config_dir/completions/*.fish
        source $file
    end

    for file in $__fish_config_dir/conf.d/*.fish
        source $file
    end
end
