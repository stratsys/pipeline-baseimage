# pipeline-baseimage

This repository provides the base Docker image used in Azure Pipelines for containerized jobs at Stratsys. The image is designed to offer a consistent, secure, and efficient environment for running CI/CD tasks, with pre-installed tools and configurations tailored for pipeline automation.

## Features

- **Standardized Environment**: Ensures all pipeline jobs run with the same system dependencies and configurations.
- **Optimized for Azure Pipelines**: Built to integrate seamlessly with Azure DevOps CI/CD workflows.
- **Extensible**: Can be used as a foundation for other images by extending the Dockerfile.
- **Security Updates**: Regularly updated to include the latest security patches.

## Usage

### In Azure Pipelines

To use this image as the base for your Azure Pipeline jobs, specify the image in your pipeline YAML:

```yaml
pool:
  vmImage: 'ubuntu-latest'

container:
  image: ghcr.io/stratsys/pipeline-baseimage:latest
```

Or if you are using a custom tag:

```yaml
container:
  image: ghcr.io/stratsys/pipeline-baseimage:<tag>
```

### As a Base Image in Your Dockerfile

You can also use this image as the base for your own custom images:

```dockerfile
FROM ghcr.io/stratsys/pipeline-baseimage:latest

# Install additional dependencies or copy your application code here
```

## Building the Image

To build the image locally:

```bash
git clone https://github.com/stratsys/pipeline-baseimage.git
cd pipeline-baseimage
docker build -t pipeline-baseimage:latest .
```

## Customization

You can extend this base image to include additional tools or dependencies as needed for your specific pipelines. Simply create your own Dockerfile and use this image as the base.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

For questions or support, contact the Stratsys DevOps team.
