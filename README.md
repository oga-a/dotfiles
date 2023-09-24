# dotfiles

My dotfiles.

## How to install

### Manual (Install with cloning)

```zsh
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply oga-a
```

If you want to apply only dotfiles, then

```zsh
sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply oga-a --exclude scripts
```

### Visual Studio Code Remote - Containers

`dotfiles.installCommand` must specify the path to the executable file.

`<user-settings-dir>/settings.json`:

```json
{
  "dotfiles.repository": "oga-a/dotfiles",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "~/dotfiles/install.sh",
}
```

### Dockerfile
To save disk space, use [`--one-shot`](https://www.chezmoi.io/reference/commands/init/#-one-shot) option.

`Dockerfile`:

```dockerfile
RUN sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply --one-shot oga-a
```

If you want to use only script files, (i.e. when dotfiles are not needed)

```dockerfile
RUN sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply --one-shot oga-a --include scripts
```
