#!/bin/bash

# Common helpers for Ferdium Server YunoHost package.

nodejs_version=22.18.0
pnpm_version=10.14.0
upstream_version=2.0.13
upstream_repo="https://github.com/ferdium/ferdium-server.git"
recipes_repo="https://github.com/ferdium/ferdium-recipes.git"
recipes_commit="a0ea0575850c851fb3f6cb620102850bda999bee"

install_ferdium_sources() {
    # install_dir is provisioned empty by YunoHost during install. On upgrades,
    # clear it before cloning the pinned upstream source again.
    find "$install_dir" -mindepth 1 -maxdepth 1 -exec rm -rf -- {} +
    git clone --branch "v${upstream_version}" --depth 1 "$upstream_repo" "$install_dir"
    ynh_safe_rm "$install_dir/recipes"
    git clone "$recipes_repo" "$install_dir/recipes"
    pushd "$install_dir/recipes"
        git checkout "$recipes_commit"
        ynh_safe_rm "$install_dir/recipes/.git"
    popd
    ynh_safe_rm "$install_dir/.git"
}

install_ferdium_dependencies() {
    # The nodejs resource from helpers 2.1 already exposes the provisioned
    # Node.js runtime in PATH for package scripts.
    corepack enable
    corepack prepare "pnpm@${pnpm_version}" --activate
    pushd "$install_dir"
        CI=1 pnpm install --frozen-lockfile
        pnpm build
        pnpm prune --prod
    popd
}

run_ferdium_migrations() {
    pushd "$install_dir"
        ENV_PATH="$install_dir/.env" node ace migration:run --force
    popd
}
